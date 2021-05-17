import 'package:mongo_dart/mongo_dart.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:mongo_repository/mongo_repository.dart';

abstract class MongoUserRepository<TUser extends UserBase<TUserCache>,
    TUserCache extends UserCacheBase> extends UserRepositoryBase<TUser> {
  final Db db;
  final EntityDb entityDb;
  Future<DbCollection> get usersCollection async => await entityDb.collection;

  MongoUserRepository(
    this.db, {
    bool secure = false,
  }) : entityDb = EntityDb(db, 'users', secure: secure);

  @override
  Future<TUser> updateUserCache(TUser user) async {
    final kh = MongoKeyHandler();
    final id = kh.keyToId(user.key);
    var query = [
      {
        '\$match': {'_id': id},
      },
      {
        '\$graphLookup': {
          'from': 'roles',
          'startWith': '\$roles',
          'connectFromField': 'roles',
          'connectToField': 'name',
          'as': 'subroles',
          'maxDepth': 1000
        }
      },
      {
        '\$project': {
          'permissions': {
            '\$reduce': {
              'input': '\$subroles.permissions',
              'initialValue': [],
              'in': {
                '\$concatArrays': ['\$\$value', '\$\$this']
              }
            }
          },
          'isAdministrator': {'\$anyElementTrue': '\$subroles.isAdministrator'},
        }
      },
    ];

    final collection = await usersCollection;
    final str = await collection.aggregateToStream(query).toList();

    var permissions =
        (str[0]['permissions'] as List).map((p) => p.toString()).toList();
    var isAdministrator = str[0]['isAdministrator'] as bool;

    var newCache = createUserCache(
        isAdministrator: isAdministrator,
        permissions: permissions,
        updateTimestamp: DateTime.now());

    if (newCache == user.cache) return user;

    user = copyUserWith(user, cache: newCache);

    var userMap = userToMap(user);
    await collection.replaceOne({'_id': id}, userMap);

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
    final collection = await usersCollection;
    final userMap = await collection.findOne({'emailAddress', username});

    if (userMap == null) {
      throw NotFound();
    }

    final user = userFromMap(userMap);
    return user;
  }

  @override
  Future<TUser> getFromKey(String key) async {
    final kh = MongoKeyHandler();
    final id = kh.keyToId(key);

    final collection = await usersCollection;
    final userMap = await collection.findOne({'_id', id});

    if (userMap == null) {
      throw NotFound();
    }

    final user = userFromMap(userMap);
    return user;
  }
}
