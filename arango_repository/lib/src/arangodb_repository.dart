import 'dart:async';

import 'package:arango_driver/arango_driver.dart' hide Transaction;
import 'package:arango_driver/arango_driver.dart' as driver show Transaction;
import 'package:nosql_repository/nosql_repository.dart'
    hide RepositoryTransaction, RepositoryTransactionOptions;
import 'package:nosql_repository/nosql_repository.dart'
    show RepositoryTransaction, RepositoryTransactionOptions;
import 'package:squarealfa_security/squarealfa_security.dart';
import 'package:tuple/tuple.dart';

import 'arangodb_repository_transaction.dart';
import 'expression_rendering/context.dart';
import 'expression_rendering/expression_extension.dart';

class ArangoDbRepository<TEntity> extends Repository<TEntity> {
  final ArangoDBClient db;
  final String collectionName;

  @override
  CreatePolicy get createPolicy =>
      CreatePolicy(permission: 'create_$collectionName');

  @override
  DeletePolicy get deletePolicy =>
      DeletePolicy(permission: 'delete_$collectionName');

  @override
  SearchPolicy get searchPolicy =>
      SearchPolicy(permission: 'search_$collectionName');

  @override
  UpdatePolicy get updatePolicy =>
      UpdatePolicy(permission: 'update_$collectionName');

  ArangoDbRepository(this.db, this.collectionName);

  @override
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> map,
    DbPrincipal principal, {
    CreatePolicy? createPolicy,
    RepositoryTransaction? transaction,
  }) async {
    if (map.containsKey('_key') && (map['_key'] ?? '') == '') {
      map.remove('_key');
    }

    createPolicy ??= this.createPolicy;
    _handleMeta(
      map,
      principal,
      createPolicy,
      createTenantKey: true,
      addRevision: true,
    );
    if (!createPolicy.isAuthorized(principal)) {
      throw Unauthorized();
    }

    final trx = _getDriverTransaction(transaction);
    var resultMap = await db.createDocument(
      collectionName,
      map,
      transaction: trx,
    );

    var key = _handleDataResult(resultMap);
    map = (await db.getDocumentByKey(
      collectionName,
      key,
      transaction: trx,
    ))
        .document;
    return map;
  }

  @override
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> map,
    DbPrincipal principal, {
    UpdatePolicy? updatePolicy,
    RepositoryTransaction? transaction,
  }) async {
    var key = map['_key'];

    var existing = await _get(
      key,
      principal,
      filterByTenant: updatePolicy?.filterByTenant ?? true,
      transaction: transaction,
    );

    updatePolicy ??= this.updatePolicy;
    _authorize(existing, principal, updatePolicy);
    map['meta'] = existing['meta'];
    _handleMeta(
      map,
      principal,
      updatePolicy,
      createTenantKey: false,
      addRevision: true,
    );

    final trx = _getDriverTransaction(transaction);
    final resultMap = await db.updateDocument(
      collectionName,
      key,
      map,
      transaction: trx,
    );
    key = _handleDataResult(resultMap);
    map = (await db.getDocumentByKey(
      collectionName,
      key,
      transaction: trx,
    ))
        .document;

    return map;
  }

  @override
  Future delete(
    String key,
    DbPrincipal principal, {
    DeletePolicy? deletePolicy,
    RepositoryTransaction? transaction,
  }) async {
    var map = await _get(key, principal);

    deletePolicy ??= this.deletePolicy;
    _handleMeta(map, principal, deletePolicy);
    _authorize(map, principal, deletePolicy);
    final trx = _getDriverTransaction(transaction);
    var result = await db.removeDocument(
      collectionName,
      key,
      transaction: trx,
    );
    _handleDataResult(result);
  }

  @override
  Future<Map<String, dynamic>> get(
    String key,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    final map = await _get(
      key,
      principal,
      transaction: transaction,
    );
    searchPolicy ??= this.searchPolicy;

    _handleMeta(map, principal, searchPolicy);
    _authorize(map, principal, searchPolicy);

    return map;
  }

  @override
  Future<Stream<Map<String, dynamic>>> getAllToStream(
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;
    var ret = _runQuery(
      '',
      principal,
      searchPolicy,
      {},
      '',
      transaction: transaction,
    );
    return ret;
  }

  @override
  Future<Stream<Map<String, dynamic>>> searchToStream(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;
    var filters = _createFilters(criteria);
    var filterQuery = filters.item1;
    var parameters = filters.item2;

    var page = _createPage(
      filterQuery,
      criteria,
      parameters,
      principal,
      searchPolicy,
      transaction: transaction,
    );

    return page;
  }

  @override
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;

    var filters = _createFilters(criteria);
    var baseQuery = filters.item1;
    var parameters = filters.item2;
    var count = await _getCount(
      baseQuery,
      parameters,
      principal,
      searchPolicy,
      transaction: transaction,
    );

    return count;
  }

  @override
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;

    var filters = _createFilters(criteria);
    var filterQuery = filters.item1;
    var parameters = filters.item2;
    var count = await (_getCount(
      filterQuery,
      {...parameters},
      principal,
      searchPolicy,
      transaction: transaction,
    ));

    var page = _createPage(
      filterQuery,
      criteria,
      parameters,
      principal,
      searchPolicy,
      transaction: transaction,
    );

    var ret = SearchResult(page, count);
    return ret;
  }

  @override
  Future<ArangoDbRepositoryTransaction> beginTransaction(
    RepositoryTransactionOptions options,
  ) async {
    final readCollections =
        _repositoryCollectionNames(options.readRepositories);
    final writeCollections =
        _repositoryCollectionNames(options.writeRepositories);
    final exclusiveCollections =
        _repositoryCollectionNames(options.exclusiveRepositories);

    final trxOptions = TransactionOptions(
      readCollections: readCollections,
      writeCollections: writeCollections,
      exclusiveCollections: exclusiveCollections,
      waitForSync: true,
    );
    final response = await db.beginTransaction(trxOptions);
    _handleResultError(response.result);

    final repoTrx = ArangoDbRepositoryTransaction(response.transaction);

    return repoTrx;
  }

  @override
  Future abortTransaction(RepositoryTransaction transaction) async {
    if (transaction is! ArangoDbRepositoryTransaction) {
      throw UnsupportedError(
          'Can only abort transactions created from an ArangoDbRepository');
    }
    await db.abortTransaction(transaction.transaction);
  }

  @override
  Future commitTransaction(RepositoryTransaction transaction) async {
    if (transaction is! ArangoDbRepositoryTransaction) {
      throw UnsupportedError(
          'Can only abort transactions created from an ArangoDbRepository');
    }
    await db.commitTransaction(transaction.transaction);
  }

  Stream<Map<String, dynamic>> _runQuery(
    String query,
    DbPrincipal principal,
    SearchPolicy searchPolicy,
    Map<String, dynamic> parameters,
    String collectionAlias, {
    RepositoryTransaction? transaction,
  }) {
    final fquery = query.isNotEmpty
        ? query
        : '''for c in ${collectionAlias.isEmpty ? collectionName : collectionAlias} return c''';

    var q = _createTenantBoundQuery(principal, searchPolicy)
      ..addLineIfThen(collectionAlias != '',
          'let $collectionAlias = (for c in $collectionName return c)')
      ..addLine(fquery);

    for (var entry in parameters.entries) {
      q = q.addBindVar(entry.key, entry.value);
    }
    final trx = _getDriverTransaction(transaction);
    var stream = q.runAndReturnStream(transaction: trx);

    return stream;
  }

  QueryWithClient _createTenantBoundQuery(
    DbPrincipal principal,
    SearchPolicy policy,
  ) {
    final action = policy.actionToDemandOnPrincipal(principal);
    if (action == '' && !policy.filterByTenant) {
      return db.newQuery();
    }

    final filterBuffer = StringBuffer();
    if (policy.filterByTenant) {
      filterBuffer.writeln(' c.meta.tenantKey == @tenantKey ');
    }
    if (action != '') {
      filterBuffer.writeln(
          ''' ${filterBuffer.isEmpty ? '' : ' && '} length(c.meta.shares[* FILTER CURRENT.userKey == @userKey && @action IN CURRENT.actions ]) > 0 ''');
    }

    final filter = filterBuffer.toString();

    var q = db.newQuery()
      ..addLine('''let $collectionName = (
                    for c in $collectionName 
                    filter $filter
                    return c
                  )''')
      ..addBindVarIfThen(
          policy.filterByTenant, 'tenantKey', principal.tenantKey)
      ..addBindVarIfThen(action != '', 'userKey', principal.userKey)
      ..addBindVarIfThen(action != '', 'action', action);
    return q;
  }

  String get actionToDemand => 'read';

  String actionToDemandOnPrincipal(
    DbPrincipal principal,
    String permission,
  ) {
    return permission != '' && principal.hasPermission(permission)
        ? ''
        : actionToDemand;
  }

  void _handleMeta(
    Map<String, dynamic> map,
    DbPrincipal principal,
    PermissionPolicy policy, {
    bool createTenantKey = false,
    bool addRevision = false,
  }) {
    var meta = (map['meta'] ??= {});
    if (addRevision) {
      var revisions = meta['revisions'] =
          (List<Map<String, dynamic>>.from(meta['revisions'] ?? []));
      revisions.add(_createRevision(principal));
    }

    if (!policy.filterByTenant) {
      return;
    }

    if (meta['tenantKey'] == null && createTenantKey) {
      meta['tenantKey'] = principal.tenantKey;
      return;
    }

    if (meta['tenantKey'] != principal.tenantKey) {
      throw Unauthorized();
    }
  }

  Map<String, dynamic> _createRevision(DbPrincipal principal) {
    return {
      'userKey': principal.userKey,
      'revisionDate': DateTime.now().toUtc().toIso8601String()
    };
  }

  Future<Map<String, dynamic>> _get(
    String key,
    DbPrincipal principal, {
    bool filterByTenant = true,
    RepositoryTransaction? transaction,
  }) async {
    final trx = _getDriverTransaction(transaction);
    final response = (await db.getDocumentByKey(
      collectionName,
      key,
      transaction: trx,
    ));
    if (response.result.error) {
      switch (response.result.errorNum) {
        case 1202:
          throw NotFound();
        default:
          throw Error();
      }
    }

    final map = response.document;

    if (filterByTenant && !_isValidateTenant(principal, map)) {
      throw Unauthorized();
    }

    return map;
  }

  bool _isValidateTenant(DbPrincipal principal, Map<String, dynamic> map) {
    final entityTenantKey = (map['meta'] ?? {})['tenantKey'] as String?;

    final isValid =
        entityTenantKey != null && entityTenantKey == principal.tenantKey;
    return isValid;
  }

  void _authorize(
    Map<String, dynamic> entity,
    DbPrincipal principal,
    EntityPermissionPolicy policy,
  ) {
    final sharePermission = policy.actionToDemandOnPrincipal(principal);
    if (sharePermission == '') {
      return;
    }

    var shares = ((entity['meta'] ?? {})['shares'] ?? []) as List;

    if (shares.any((s) =>
        s['userKey'] == principal.userKey &&
        (s['actions'] ?? []).contains(sharePermission))) {
      return;
    }

    throw Unauthorized();
  }

  String _handleDataResult(OperationResult operationResult) {
    _handleResultError(operationResult.result);
    return operationResult.identifier.key;
  }

  Tuple2<String, Map<String, dynamic>> _createFilters(SearchCriteria criteria) {
    var context = Context();
    var buffer = StringBuffer();
    for (var condition in criteria.searchConditions) {
      var expression = condition.render(context);
      buffer.writeln('FILTER $expression');
    }
    var ret = Tuple2(buffer.toString(), context.parameters);
    return ret;
  }

  Stream<Map<String, dynamic>> _createPage(
    String filterQuery,
    SearchCriteria criteria,
    Map<String, dynamic> parameters,
    DbPrincipal principal,
    SearchPolicy searchPolicy, {
    RepositoryTransaction? transaction,
  }) {
    final queryBuffer = StringBuffer();

    queryBuffer.writeln('FOR entity in entities ');
    queryBuffer.writeln(filterQuery);

    var sort = _createSort(criteria);
    queryBuffer.writeln(sort);

    if (criteria.skip != null || criteria.take != null) {
      if (criteria.skip == null) {
        queryBuffer.writeln('LIMIT @take');
        parameters.addAll({'take': criteria.take});
      } else if (criteria.take == null) {
        queryBuffer.writeln('LIMIT @skip, null');
        parameters.addAll({'skip': criteria.skip});
      } else {
        queryBuffer.writeln('LIMIT @skip, @take');
        parameters.addAll({'skip': criteria.skip, 'take': criteria.take});
      }
    }

    var retrn = _createReturn(criteria);
    queryBuffer.writeln(retrn);

    var query = queryBuffer.toString();

    var page = _runQuery(
      query,
      principal,
      searchPolicy,
      parameters,
      'entities',
      transaction: transaction,
    );
    return page;
  }

  String _createSort(SearchCriteria criteria) {
    var sortBuffer = StringBuffer();
    for (var f in criteria.orderByFields) {
      if (sortBuffer.isEmpty) {
        sortBuffer.write(sortBuffer.isEmpty ? 'sort' : ',');
      }
      sortBuffer.write(
          ' entity.${_sanitizePath(f.path)} ${f.isDescending ? 'desc' : ''} ');
    }

    return sortBuffer.toString();
  }

  String _createReturn(SearchCriteria criteria) {
    if ((criteria.returnFields).isEmpty) {
      return 'RETURN entity';
    }

    var sb = StringBuffer();

    for (var rf in criteria.returnFields) {
      if (sb.isEmpty) {
        sb.write('RETURN {');
      } else {
        sb.write(', ');
      }

      var alias = rf.alias ?? rf.path.replaceAll('.', '_');
      sb.write(' $alias : entity.${rf.path} ');
    }
    sb.write('}');

    var ret = sb.toString();
    return ret;
  }

  Future<int> _getCount(
    String query,
    Map<String, dynamic> parameters,
    DbPrincipal principal,
    SearchPolicy searchPolicy, {
    RepositoryTransaction? transaction,
  }) async {
    var countQuery = '''FOR entity in entities 
           $query
           return { 'cnt' : LENGTH(entities) }
         ''';
    var count = (await _runQuery(
      countQuery,
      principal,
      searchPolicy,
      parameters,
      'entities',
      transaction: transaction,
    ).first)['cnt'] as int;

    return count;
  }

  String _sanitizePath(String path) {
    var sanitized = path.replaceAll(RegExp(r'[^a-zA-Z0-9\.\_]'), '');
    return sanitized;
  }

  void _handleResultError(Result result) {
    if (!result.error) {
      return;
    }
    throw DbException(
      message: result.errorMessage,
      code: result.code.toString(),
      number: result.errorNum.toString(),
    );
  }

  List<String> _repositoryCollectionNames(List<Repository> repositories) {
    final names = repositories
        .map((r) => r is! ArangoDbRepository ? '' : r.collectionName)
        .where((r) => r.isNotEmpty)
        .toList();
    return names;
  }

  driver.Transaction? _getDriverTransaction(
      RepositoryTransaction? transaction) {
    if (transaction == null || transaction is! ArangoDbRepositoryTransaction) {
      return null;
    }
    return transaction.transaction;
  }
}
