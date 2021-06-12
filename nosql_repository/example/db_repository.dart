import 'package:nosql_repository/nosql_repository.dart';
import 'package:nosql_repository/src/policy/create_policy.dart';

/// Simulates a repository to an entity type
/// by storing instances into a map instead of a real
/// database.
class DbRepository<T> extends Repository<T> {
  final String collectionName;
  static int _latestKey = 0;
  static final Map<String, Map<String, dynamic>> _storedMaps = {};

  DbRepository(this.collectionName);

  @override
  CreatePolicy get createPolicy =>
      CreatePolicy(permission: 'create_$collectionName');

  @override
  SearchPolicy get searchPolicy =>
      SearchPolicy(permission: 'read_$collectionName');

  @override
  UpdatePolicy get updatePolicy =>
      UpdatePolicy(permission: 'update_$collectionName');

  @override
  DeletePolicy get deletePolicy =>
      DeletePolicy(permission: 'delete_$collectionName');

  @override
  Future<Map<String, dynamic>> create(
      Map<String, dynamic> map, DbPrincipal principal,
      {CreatePolicy? createPolicy, RepositoryTransaction? transaction}) async {
    print(
        '''This method would create the map in the database, in the $collectionName collection.
           It would fail if the [permission] parameter is set and the user principal does not
           have that permission.
           It would add ownership information to the collection, like for instance
           the tenantKey of the user principal.
        ''');
    createPolicy ??= this.createPolicy;
    final permission = createPolicy.permission;

    if (permission != '' && !principal.hasPermission(permission)) {
      throw Error();
    }
    final key = (++_latestKey).toString();
    map['_key'] = key;
    _storedMaps[key] = map;
    return map;
  }

  @override
  Future delete(
    String key,
    DbPrincipal principal, {
    DeletePolicy? deletePolicy,
    RepositoryTransaction? transaction,
  }) async {
    _storedMaps.remove(key);
  }

  @override
  Future<Map<String, dynamic>> get(String key, DbPrincipal principal,
      {SearchPolicy? searchPolicy, RepositoryTransaction? transaction}) async {
    return Future.value(_storedMaps[key]);
  }

  @override
  Future<Stream<Map<String, dynamic>>> getAllToStream(
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    return _getAllToStream(principal, searchPolicy);
  }

  Stream<Map<String, dynamic>> _getAllToStream(
    DbPrincipal principal, [
    SearchPolicy? searchPolicy,
  ]) async* {
    for (var item in _storedMaps.values) {
      yield item;
    }
  }

  @override
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> map,
    DbPrincipal principal, {
    UpdatePolicy? updatePolicy,
    RepositoryTransaction? transaction,
  }) {
    _storedMaps[map['_key']] = map;
    return Future.value(map);
  }

  @override
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Stream<Map<String, dynamic>>> searchToStream(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    RepositoryTransaction? transaction,
  }) {
    throw UnimplementedError();
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
