import 'dart:async';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

import 'entity_db.dart';
// import 'expression_rendering/context.dart';
// import 'expression_rendering/expression_extension.dart';

class MongoRepository<TEntity> extends Repository<TEntity> {
  final Db db;
  final String collectionName;
  final EntityDb entityDb;

  MongoRepository(
    this.db,
    this.collectionName, {
    bool secure = false,
  }) : entityDb = EntityDb(db, collectionName, secure: secure);

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

  @override
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> map,
    DbPrincipal principal, [
    CreatePolicy? createPolicy,
  ]) async {
    if (map['_id'] == null) {
      map['_id'] = ObjectId();
    }
    final key = map['_id'] as ObjectId;

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

    try {
      final collection = await entityDb.collection;
      await collection.insert(map);
      final result = await collection.find(where.eq('_id', key)).single;
      return result;
    } catch (ex) {
      throw _exToDbException(ex);
    }
  }

  @override
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> map,
    DbPrincipal principal, [
    UpdatePolicy? updatePolicy,
  ]) async {
    var id = map['_id'] as ObjectId;

    var existing = await _getFromObjectId(
      id,
      principal,
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

    try {
      final collection = await entityDb.collection;
      final wr = await collection.replaceOne({'_id': id}, map);
      if (wr.hasWriteErrors) {
        throw _writeErrorToException(wr);
      }
      final result = await collection.find(where.eq('_id', id)).single;
      return result;
    } on DbException {
      rethrow;
    } catch (ex) {
      throw _exToDbException(ex);
    }
  }

  @override
  Future delete(
    String id,
    DbPrincipal principal, [
    DeletePolicy? deletePolicy,
  ]) async {
    var map = await _getFromId(id, principal);

    deletePolicy ??= this.deletePolicy;
    _handleMeta(map, principal, deletePolicy);
    _authorize(map, principal, deletePolicy);

    try {
      final collection = await entityDb.collection;
      await collection.remove(where.eq('_id', ObjectId.fromHexString(id)));
    } on DbException {
      rethrow;
    } catch (ex) {
      throw _exToDbException(ex);
    }
  }

  @override
  Future<Map<String, dynamic>> get(
    String id,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    final map = await _getFromId(id, principal);
    searchPolicy ??= this.searchPolicy;

    _handleMeta(map, principal, searchPolicy);
    _authorize(map, principal, searchPolicy);

    return map;
  }

  @override
  Future<Stream<Map<String, dynamic>>> getAllToStream(
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    searchPolicy ??= this.searchPolicy;

    final collection = await entityDb.collection;
    final stream = collection.aggregateToStream([]);
    return stream;
    // var ret = _runQuery('', principal, searchPolicy, {}, '');
    // return ret;
  }

  @override
  Future<Stream<Map<String, dynamic>>> searchToStream(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) {
    searchPolicy ??= this.searchPolicy;
    throw UnimplementedError();
    // var filters = _createFilters(criteria);
    // var filterQuery = filters.item1;
    // var parameters = filters.item2;

    // var page = _createPage(
    //   filterQuery,
    //   criteria,
    //   parameters,
    //   principal,
    //   searchPolicy,
    // );

    // return page;
  }

  @override
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    throw UnimplementedError();
    // searchPolicy ??= this.searchPolicy;

    // var filters = _createFilters(criteria);
    // var baseQuery = filters.item1;
    // var parameters = filters.item2;
    // var count = await _getCount(
    //   baseQuery,
    //   parameters,
    //   principal,
    //   searchPolicy,
    // );

    // return count;
  }

  @override
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async {
    throw UnimplementedError();
    // searchPolicy ??= this.searchPolicy;

    // var filters = _createFilters(criteria);
    // var filterQuery = filters.item1;
    // var parameters = filters.item2;
    // var count = await (_getCount(
    //   filterQuery,
    //   {...parameters},
    //   principal,
    //   searchPolicy,
    // ));

    // var page = _createPage(
    //   filterQuery,
    //   criteria,
    //   parameters,
    //   principal,
    //   searchPolicy,
    // );

    // var ret = SearchResult(page, count);
    // return ret;
  }

  DbException _exToDbException(Object ex) {
    final map = ex is Map<String, dynamic> ? ex : {};

    final ret = DbException(
      message: map['err'] ?? 'undetermined',
      code: (map['code'] ?? '').toString(),
      number: map['codeName'] ?? '',
    );
    return ret;
  }

  DbException _writeErrorToException(WriteResult wr) {
    return DbException(
      message: wr.errmsg,
      code: wr.code.toString(),
      number: wr.codeName,
    );
  }

  // Stream<Map<String, dynamic>> _runQuery(
  //   String query,
  //   DbPrincipal principal,
  //   SearchPolicy searchPolicy,
  //   Map<String, dynamic> parameters,
  //   String collectionAlias,
  // ) {
  //   var q = createTenantBoundQuery(principal, searchPolicy)
  //     ..addLineIfThen(collectionAlias != '',
  //         'let $collectionAlias = (for c in $collectionName return c)')
  //     ..addLineIfThen(query != '', query);

  //   for (var entry in parameters.entries) {
  //     q = q.addBindVar(entry.key, entry.value);
  //   }
  //   var stream = q.runAndReturnStream();

  //   return stream;
  // }

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
  //       : '''&& length(c.meta.shares[* FILTER CURRENT.userKey == @userKey
  // && @action IN CURRENT.actions ]) > 0 ''';

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

  Future<Map<String, dynamic>> _getFromId(
      String id, DbPrincipal principal) async {
    final oid = ObjectId.fromHexString(id);
    final ret = await _getFromObjectId(oid, principal);
    return ret;
  }

  Future<Map<String, dynamic>> _getFromObjectId(
      ObjectId oid, DbPrincipal principal) async {
    try {
      var collection = await entityDb.collection;
      var map = await collection.find(where.eq('_id', oid)).single;

      if (!_isValidateTenant(principal, map)) {
        throw Unauthorized();
      }

      return map;
    } catch (ex) {
      throw _exToDbException(ex);
    }
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

  // String _handleDataResult(OperationResult operationResult) {
  //   if (operationResult.result.error) {
  //     throw DbException(
  //       message: operationResult.result.errorMessage,
  //       code: operationResult.result.code.toString(),
  //       number: operationResult.result.errorNum.toString(),
  //     );
  //   }
  //   return operationResult.identifier.key;
  // }

  // Tuple2<String, Map<String, dynamic>>
  // _createFilters(SearchCriteria criteria) {
  //   var context = Context();
  //   var buffer = StringBuffer();
  //   for (var condition in criteria.searchConditions) {
  //     var expression = condition.render(context);
  //     buffer.writeln('FILTER $expression');
  //   }
  //   var ret = Tuple2(buffer.toString(), context.parameters);
  //   return ret;
  // }

  // Stream<Map<String, dynamic>> _createPage(
  //   String filterQuery,
  //   SearchCriteria criteria,
  //   Map<String, dynamic> parameters,
  //   DbPrincipal principal,
  //   SearchPolicy searchPolicy,
  // ) {
  //   final queryBuffer = StringBuffer();

  //   queryBuffer.writeln('FOR entity in entities ');
  //   queryBuffer.writeln(filterQuery);

  //   var sort = _createSort(criteria);
  //   queryBuffer.writeln(sort);

  //   if (criteria.skip != null || criteria.take != null) {
  //     queryBuffer.writeln('LIMIT @skip, @take');
  //     parameters.addAll({'skip': criteria.skip, 'take': criteria.take});
  //   }

  //   var retrn = _createReturn(criteria);
  //   queryBuffer.writeln(retrn);

  //   var query = queryBuffer.toString();

  //   var page = _runQuery(
  //     query,
  //     principal,
  //     searchPolicy,
  //     parameters,
  //     'entities',
  //   );
  //   return page;
  // }

  // String _createSort(SearchCriteria criteria) {
  //   var sortBuffer = StringBuffer();
  //   for (var f in criteria.orderByFields) {
  //     if (sortBuffer.isEmpty) {
  //       sortBuffer.write(sortBuffer.isEmpty ? 'sort' : ',');
  //     }
  //     sortBuffer.write(' entity.${_sanitizePath(f.path)}');
  //   }

  //   return sortBuffer.toString();
  // }

  // String _createReturn(SearchCriteria criteria) {
  //   if ((criteria.returnFields).isEmpty) {
  //     return 'RETURN entity';
  //   }

  //   var sb = StringBuffer();

  //   for (var rf in criteria.returnFields) {
  //     if (sb.isEmpty) {
  //       sb.write('RETURN {');
  //     } else {
  //       sb.write(', ');
  //     }

  //     var alias = rf.alias ?? rf.path!.replaceAll('.', '_');
  //     sb.write(' $alias : entity.${rf.path} ');
  //   }
  //   sb.write('}');

  //   var ret = sb.toString();
  //   return ret;
  // }

  // Future<int> _getCount(
  //   String query,
  //   Map<String, dynamic> parameters,
  //   DbPrincipal principal,
  //   SearchPolicy searchPolicy,
  // ) async {
  //   var countQuery = 'RETURN { cnt: length($query) }';
  //   var count = (await _runQuery(
  //     countQuery,
  //     principal,
  //     searchPolicy,
  //     parameters,
  //     'entities',
  //   ).first)['cnt'] as int;

  //   return count;
  // }

  // String _sanitizePath(String path) {
  //   var sanitized = path.replaceAll(RegExp(r'[^a-zA-Z0-9\.\_]'), '');
  //   return sanitized;
  // }
  //
}
