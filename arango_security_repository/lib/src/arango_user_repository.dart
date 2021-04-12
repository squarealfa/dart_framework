import 'package:arango_driver/arango_driver.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';

class ArangoUserRepository extends UserRepository {
  final ArangoDBClient _dbClient;

  ArangoUserRepository(ArangoDBClient dbClient) : _dbClient = dbClient;

  @override
  Future<User> updateUserCache(User user) async {
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
        .addBindVar('user_key', user.emailAddress)
        .runAndReturnFutureList());

    var result = lst.first;

    var isAdministrator = result['isAdministrator'];
    var permissions =
        (result['permissions'] as List?)?.map((i) => i as String).toList() ??
            [];

    var newCache = UserCache(
        isAdministrator: isAdministrator,
        permissions: permissions,
        updateTimestamp: DateTime.now());

    if (newCache == user.cache) return user;

    user = user.copyWith(cache: newCache);

    var userMap = user.toMap();
    await _dbClient.replaceDocument('users', user.key, userMap);

    return user;
  }

  @override
  Future<User> getFromUsername(String username) async {
    var userList = await _dbClient.newQuery().addLine('''
            for c in users
            filter c.emailAddress == @emailAddress
            limit 1
            return c
          ''').addBindVar('emailAddress', username).runAndReturnFutureList();
    if (userList.isEmpty) {
      throw NotFound();
    }
    var userMap = userList.first;

    var user = userMap.toUser();
    return user;
  }

  @override
  Future<User> getFromKey(String key) async {
    var userList = await _dbClient.newQuery().addLine('''
            for c in users
            filter u._key == @key
            limit 1
            return c
          ''').addBindVar('key', key).runAndReturnFutureList();
    if (userList.isEmpty) {
      throw NotFound();
    }
    var userMap = userList.first;

    var user = userMap.toUser();
    return user;
  }
}
