import 'dart:async';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

import 'entity_db.dart';
import 'expression_rendering/expression_extension.dart';

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
    DbPrincipal principal, {
    CreatePolicy? createPolicy,
    RepositoryTransaction? transaction,
  }) async {
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
    DbPrincipal principal, {
    UpdatePolicy? updatePolicy,
    RepositoryTransaction? transaction,
  }) async {
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
    DbPrincipal principal, {
    DeletePolicy? deletePolicy,
    RepositoryTransaction? transaction,
  }) async {
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
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    final map = await _getFromId(id, principal);
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

    final collection = await entityDb.collection;
    final pipeline = AggregationPipelineBuilder();
    addAccessFilters(pipeline, searchPolicy, principal);
    final stages = pipeline.build();
    final stream = collection.aggregateToStream(stages);
    return stream;
  }

  @override
  Future<Stream<Map<String, dynamic>>> searchToStream(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;

    final pipeline = AggregationPipelineBuilder();

    addAccessFilters(pipeline, searchPolicy, principal);

    for (final exp in criteria.searchConditions) {
      final stage = exp.render();
      pipeline.addStage(stage);
    }

    _addSort(criteria, pipeline);
    if (criteria.skip != null) {
      pipeline.addStage(Skip(criteria.skip!));
    }
    if (criteria.take != null) {
      pipeline.addStage(Limit(criteria.take!));
    }

    _addProjection(criteria, pipeline);

    final stages = pipeline.build();

    final collection = await entityDb.collection;
    final stream = collection.aggregateToStream(stages);
    return stream;
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

  void addAccessFilters(AggregationPipelineBuilder pipeline,
      SearchPolicy searchPolicy, DbPrincipal principal) {
    if (searchPolicy.filterByTenant) {
      pipeline.addStage(Match(where
          .eq('meta.tenantId', ObjectId.fromHexString(principal.tenantKey))
          .map[r'$query']));
    }

    final action = searchPolicy.actionToDemandOnPrincipal(principal);
    if (action.isNotEmpty) {
      pipeline.addStage(Unwind(Field('meta.shares')));
      pipeline.addStage(Match({
        'meta.shares.userKey': principal.userKey,
        'meta.shares.actions': 'read',
      }));
    }
  }

  @override
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    searchPolicy ??= this.searchPolicy;

    final pipeline = AggregationPipelineBuilder();

    addAccessFilters(pipeline, searchPolicy, principal);

    for (final exp in criteria.searchConditions) {
      final stage = exp.render();
      pipeline.addStage(stage);
    }

    pipeline.addStage(Count('cnt'));

    final stages = pipeline.build();

    final collection = await entityDb.collection;
    final lst = await collection.aggregateToStream(stages).toList();
    final cnt = lst.first['cnt'] as int;
    return cnt;
  }

  @override
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    final cnt = await count(criteria, principal, searchPolicy: searchPolicy);
    final page =
        await searchToStream(criteria, principal, searchPolicy: searchPolicy);

    final sr = SearchResult(page, cnt);
    return sr;
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

    final tenantId = ObjectId.fromHexString(principal.tenantKey);

    if (meta['tenantId'] == null && createTenantKey) {
      meta['tenantId'] = tenantId;
      return;
    }

    if (meta['tenantId'] != tenantId) {
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
    final entityTenantId = (map['meta'] ?? {})['tenantId'] as ObjectId?;

    final isValid = entityTenantId != null &&
        entityTenantId.toHexString() == principal.tenantKey;
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

  void _addSort(SearchCriteria criteria, AggregationPipelineBuilder pipeline) {
    if (criteria.orderByFields.isEmpty) {
      return;
    }

    final map = <String, dynamic>{};
    for (final orf in criteria.orderByFields) {
      map[orf.path] = orf.isDescending ? -1 : 1;
    }

    pipeline.addStage(Sort(map));
  }

  void _addProjection(
    SearchCriteria criteria,
    AggregationPipelineBuilder pipeline,
  ) {
    if (criteria.returnFields.isEmpty) {
      return;
    }
    final map = <String, dynamic>{};

    for (final rf in criteria.returnFields) {
      final fname = rf.alias ?? rf.path.replaceAll('.', '_');
      map[fname] = '\$${rf.path}';
    }
    if (!criteria.returnFields.any((rf) => rf.path == '_id')) {
      map['_id'] = 0;
    }

    pipeline.addStage(Project(map));
  }

  @override
  Future abortTransaction(RepositoryTransaction transaction) {
    throw UnimplementedError();
  }

  @override
  Future<RepositoryTransaction> beginTransaction(
      RepositoryTransactionOptions options) {
    throw UnimplementedError();
  }

  @override
  Future commitTransaction(RepositoryTransaction transaction) {
    throw UnimplementedError();
  }
}
