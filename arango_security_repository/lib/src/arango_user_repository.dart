import 'package:arango_driver/arango_driver.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';

class ArangoUserRepository extends UserRepositoryBase {
  final ArangoDBClient _dbClient;
  final String collectionName;

  ArangoUserRepository(ArangoDBClient dbClient, this.collectionName)
      : _dbClient = dbClient;

  @override
  Future<UserPermissionSet> getUserPermissionSet(String userKey) async {
    var query = '''
        let uroles =  document('users', @user_key).roles == null ? [] : document('users', @user_key).roles

        let lroles = (for role in roles
            for urole in uroles
            filter role._key == urole
        return role)

        let allroles = flatten([(for role in lroles
            for v, e, p in 1..100 outbound role role_assignments
            return v), lroles])

        let permissions = unique(flatten(for role in allroles return role.permissions))
        let isAdministrator = first(for role in allroles filter role.isAdministrator == true limit 1 return role) != null

        return {
            permissions,
            isAdministrator
            }
    ''';

    var lst = (await _dbClient
        .newQuery()
        .addLine(query)
        .addBindVar('user_key', userKey)
        .runAndReturnFutureList());

    var result = lst.first;

    var isAdministrator = result['isAdministrator'];
    var permissions =
        (result['permissions'] as List?)?.map((i) => i as String).toList() ??
            [];

    final ret = UserPermissionSet(
        isAdministrator: isAdministrator, permissions: permissions);
    return ret;
  }

  @override
  Future<Map<String, dynamic>> getFromKey(String key) async {
    var userList = await _dbClient.newQuery().addLine('''
            for c in users
            filter u._key == @key
            limit 1
            return c
          ''').addBindVar('key', key).runAndReturnFutureList();
    if (userList.isEmpty) {
      throw NotFound();
    }
    final userMap = userList.first;
    return userMap;
  }

  @override
  Future<Map<String, dynamic>> getFromUsername(String username) async {
    var userList = await _dbClient.newQuery().addLine('''
            for c in users
            filter c.username == @username
            limit 1
            return c
          ''').addBindVar('username', username).runAndReturnFutureList();
    if (userList.isEmpty) {
      throw NotFound();
    }
    final userMap = userList.first;
    return userMap;
  }

  @override
  Future<Map<String, dynamic>> updateUser(
      String key, Map<String, dynamic> userMap) async {
    final opResult = await _dbClient.replaceDocument('users', key, userMap);
    final result = opResult.result;
    if (result.error) {
      throw DbException(
        code: result.code.toString(),
        message: result.errorMessage,
        number: result.errorNum.toString(),
      );
    }

    return opResult.map;
  }
}
