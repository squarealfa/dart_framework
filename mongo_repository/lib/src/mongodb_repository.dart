import 'dart:async';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:squarealfa_security/squarealfa_security.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:tuple/tuple.dart';

import 'expression_rendering/context.dart';
import 'expression_rendering/expression_extension.dart';

class MongoDbRepository<TEntity> implements Repository<TEntity> {
  final Db db;
  final DbCollection collection;
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

  MongoDbRepository(this.db, this.collectionName)
      : collection = db.collection(collectionName);

  @override
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> map,
    DbPrincipal principal, [
    CreatePolicy? createPolicy,
  ]) async {
    if (map.containsKey('_id') && (map['_id'] ?? '') == '') {
      map.remove('_id');
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
    var resultMap = await collection.insert(map);

    var key = _handleDataResult(resultMap);

    map = (await collection.find(where.eq('_id', key)).first);
    return map;
  }

  @override
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> map,
    DbPrincipal principal, [
    UpdatePolicy? updatePolicy,
  ]) async {
    throw UnimplementedError();
    // var key = map['_key'];

    // var existing = await _get(
    //   key,
    //   principal,
    // );

    // updatePolicy ??= this.updatePolicy;
    // _authorize(existing, principal, updatePolicy);
    // map['meta'] = existing['meta'];
    // _handleMeta(
    //   map,
    //   principal,
    //   updatePolicy,
    //   createTenantKey: false,
    //   addRevision: true,
    // );

    // var resultMap = await db.updateDocument(collectionName, key, map);
    // key = _handleDataResult(resultMap);
    // map = (await db.getDocumentByKey(collectionName, key)).document;

    // return map;
  }

  @override
  Future delete(
    String key,
    DbPrincipal principal, [
    DeletePolicy? deletePolicy,
  ]) async {
    throw UnimplementedError();
    // var map = await _get(key, principal);

    // deletePolicy ??= this.deletePolicy;
    // _handleMeta(map, principal, deletePolicy);
    // _authorize(map, principal, deletePolicy);
    // var result = await db.removeDocument(collectionName, key);
    // _handleDataResult(result);
  }

  @override
  Future<Map<String, dynamic>> get(
    String key,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    final map = await _get(key, principal);
    searchPolicy ??= this.searchPolicy;

    _handleMeta(map, principal, searchPolicy);
    _authorize(map, principal, searchPolicy);

    return map;
  }

  @override
  Stream<Map<String, dynamic>> getAll(
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) {
    searchPolicy ??= this.searchPolicy;
    var ret = _runQuery('', principal, searchPolicy, {}, '');
    return ret;
  }

  @override
  Stream<Map<String, dynamic>> search(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) {
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
    );

    return page;
  }

  @override
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    searchPolicy ??= this.searchPolicy;

    var filters = _createFilters(criteria);
    var baseQuery = filters.item1;
    var parameters = filters.item2;
    var count = await _getCount(
      baseQuery,
      parameters,
      principal,
      searchPolicy,
    );

    return count;
  }

  @override
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    searchPolicy ??= this.searchPolicy;

    var filters = _createFilters(criteria);
    var filterQuery = filters.item1;
    var parameters = filters.item2;
    var count = await (_getCount(
      filterQuery,
      {...parameters},
      principal,
      searchPolicy,
    ));

    var page = _createPage(
      filterQuery,
      criteria,
      parameters,
      principal,
      searchPolicy,
    );

    var ret = SearchResult(page, count);
    return ret;
  }

  Stream<Map<String, dynamic>> _runQuery(
    String query,
    DbPrincipal principal,
    SearchPolicy searchPolicy,
    Map<String, dynamic> parameters,
    String collectionAlias,
  ) {
    throw UnimplementedError();
    // var q = createTenantBoundQuery(principal, searchPolicy)
    //   ..addLineIfThen(collectionAlias != '',
    //       'let $collectionAlias = (for c in $collectionName return c)')
    //   ..addLineIfThen(query != '', query);

    // for (var entry in parameters.entries) {
    //   q = q.addBindVar(entry.key, entry.value);
    // }
    // var stream = q.runAndReturnStream();

    // return stream;
  }

  // QueryWithClient createTenantBoundQuery(
  //   DbPrincipal principal,
  //   SearchPolicy policy,
  // ) {
  //   final action = policy.actionToDemandOnPrincipal(principal);
  //   if (action == '' && !policy.filterByTenant) {
  //     return db.newQuery();
  //   }
  //   final actionFilter = action == ''
  //       ? ''
  //       : '''&& length(c.meta.shares[* FILTER CURRENT.userKey == @userKey && @action IN CURRENT.actions ]) > 0 ''';

  //   var q = db.newQuery()
  //     ..addLine('''let $collectionName = (
  //                   for c in $collectionName
  //                   filter c.meta.tenantKey == @tenantKey
  //                     $actionFilter
  //                   return c
  //                 )''')
  //     ..addBindVar('tenantKey', principal.tenantKey)
  //     ..addBindVarIfThen(action != '', 'userKey', principal.userKey)
  //     ..addBindVarIfThen(action != '', 'action', action);
  //   return q;
  // }

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

  Future<Map<String, dynamic>> _get(String key, DbPrincipal principal) async {
    throw UnimplementedError();
    // final response = (await db.getDocumentByKey(collectionName, key));
    // if (response.result.error) {
    //   switch (response.result.errorNum) {
    //     case 1202:
    //       throw NotFound();
    //     default:
    //       throw Error();
    //   }
    // }

    // final map = response.document;

    // if (!_isValidateTenant(principal, map)) {
    //   throw Unauthorized();
    // }

    // return map;
  }

  // bool _isValidateTenant(DbPrincipal principal, Map<String, dynamic> map) {
  //   final entityTenantKey = (map['meta'] ?? {})['tenantKey'] as String?;

  //   final isValid =
  //       entityTenantKey != null && entityTenantKey == principal.tenantKey;
  //   return isValid;
  // }

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

  String _handleDataResult(Map<String, dynamic> operationResult) {
    return operationResult['_id'].toString();
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
    SearchPolicy searchPolicy,
  ) {
    final queryBuffer = StringBuffer();

    queryBuffer.writeln('FOR entity in entities ');
    queryBuffer.writeln(filterQuery);

    var sort = _createSort(criteria);
    queryBuffer.writeln(sort);

    if (criteria.skip != null || criteria.take != null) {
      queryBuffer.writeln('LIMIT @skip, @take');
      parameters.addAll({'skip': criteria.skip, 'take': criteria.take});
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
    );
    return page;
  }

  String _createSort(SearchCriteria criteria) {
    var sortBuffer = StringBuffer();
    for (var f in criteria.orderByFields) {
      if (sortBuffer.isEmpty) {
        sortBuffer.write(sortBuffer.isEmpty ? 'sort' : ',');
      }
      sortBuffer.write(' entity.${_sanitizePath(f.path)}');
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

      var alias = rf.alias ?? rf.path!.replaceAll('.', '_');
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
    SearchPolicy searchPolicy,
  ) async {
    var countQuery = 'RETURN { cnt: length($query) }';
    var count = (await _runQuery(
      countQuery,
      principal,
      searchPolicy,
      parameters,
      'entities',
    ).first)['cnt'] as int;

    return count;
  }

  String _sanitizePath(String path) {
    var sanitized = path.replaceAll(RegExp(r'[^a-zA-Z0-9\.\_]'), '');
    return sanitized;
  }
}
