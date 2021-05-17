import 'package:arango_driver/arango_driver.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';

abstract class ArangoUserRepositoryBase<TUser extends UserBase<TUserCache>,
    TUserCache extends UserCacheBase> extends UserRepositoryBase<TUser> {
  final ArangoDBClient _dbClient;

  ArangoUserRepositoryBase(ArangoDBClient dbClient) : _dbClient = dbClient;

  @override
  Future<TUser> updateUserCache(TUser user) async {
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
        .addBindVar('user_key', user.username)
        .runAndReturnFutureList());

    var result = lst.first;

    var isAdministrator = result['isAdministrator'];
    var permissions =
        (result['permissions'] as List?)?.map((i) => i as String).toList() ??
            [];

    var newCache = createUserCache(
        isAdministrator: isAdministrator,
        permissions: permissions,
        updateTimestamp: DateTime.now());

    if (newCache != user.cache) {
      return user;
    }

    user = copyUserWith(user, cache: newCache);

    var userMap = userToMap(user);
    await _dbClient.replaceDocument('users', user.key, userMap);

    return user;
  }

  TUserCache createUserCache({
    required bool isAdministrator,
    required List<String> permissions,
    required DateTime updateTimestamp,
  });
  TUser copyUserWith(TUser user, {required TUserCache cache});

  Map<String, dynamic> userToMap(TUser user);
  TUser userFromMap(Map<String, dynamic> map);

  @override
  Future<TUser> getFromUsername(String username) async {
    var userList = await _dbClient.newQuery().addLine('''
            for c in users
            filter c.emailAddress == @emailAddress
            limit 1
            return c
          ''').addBindVar('emailAddress', username).runAndReturnFutureList();
    if (userList.isEmpty) {
      throw NotFound();
    }
    final userMap = userList.first;
    final user = userFromMap(userMap);
    return user;
  }

  @override
  Future<TUser> getFromKey(String key) async {
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

    //var user = userMap.toUser();
    final user = userFromMap(userMap);
    return user;
  }
}
