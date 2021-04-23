import 'package:mongo_dart/mongo_dart.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:mongo_repository/mongo_repository.dart';

class MongoUserRepository extends UserRepository {
  final Db db;
  final EntityDb entityDb;
  Future<DbCollection> get usersCollection async => await entityDb.collection;

  MongoUserRepository(
    this.db, {
    bool secure = false,
  }) : entityDb = EntityDb(db, 'users', secure: secure);

  @override
  Future<User> updateUserCache(User user) async {
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

    var newCache = UserCache(
        isAdministrator: isAdministrator,
        permissions: permissions,
        updateTimestamp: DateTime.now());

    if (newCache == user.cache) return user;

    user = user.copyWith(cache: newCache);

    var userMap = user.toMap();
    await collection.replaceOne({'_id': id}, userMap);

    return user;
  }

  @override
  Future<User> getFromUsername(String username) async {
    final collection = await usersCollection;
    final userMap = await collection.findOne({'emailAddress', username});

    if (userMap == null) {
      throw NotFound();
    }

    final user = userMap.toUser();
    return user;
  }

  @override
  Future<User> getFromKey(String key) async {
    final kh = MongoKeyHandler();
    final id = kh.keyToId(key);

    final collection = await usersCollection;
    final userMap = await collection.findOne({'_id', id});

    if (userMap == null) {
      throw NotFound();
    }

    final user = userMap.toUser();
    return user;
  }
}
