import 'package:mongo_dart/mongo_dart.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:mongo_repository/mongo_repository.dart';

class MongoUserRepository implements UserSecurityRepository {
  final Db db;
  final EntityDb entityDb;
  Future<DbCollection> get usersCollection async => await entityDb.collection;

  MongoUserRepository(
    this.db, {
    bool secure = false,
  }) : entityDb = EntityDb(db, 'users', secure: secure);

  @override
  Future<UserPermissionSet> getUserPermissionSet(String userKey) async {
    final kh = MongoKeyHandler();
    final id = kh.keyToId(userKey);
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
        (str[0]['permissions'] as List).map((p) => p.toString()).toSet();
    var isAdministrator = str[0]['isAdministrator'] as bool;

    final permissionSet = UserPermissionSet(
      permissions: permissions,
      isAdministrator: isAdministrator,
    );

    return permissionSet;
  }

  @override
  Future<Map<String, dynamic>> getFromUsername(String username) async {
    final collection = await usersCollection;
    final userMap = await collection.findOne({'emailAddress', username});

    if (userMap == null) {
      throw NotFound();
    }

    return userMap;
  }

  @override
  Future<Map<String, dynamic>> updateUser(
      String key, Map<String, dynamic> userMap) async {
    final kh = MongoKeyHandler();
    final id = kh.keyToId(key);

    final collection = await usersCollection;
    final wr = await collection.replaceOne({'_id': id}, userMap);
    if (wr.hasWriteErrors) {
      throw _writeErrorToException(wr);
    }
    final result = await collection.find(where.eq('_id', id)).single;
    return result;
  }

  DbException _writeErrorToException(WriteResult wr) {
    return DbException(
      message: wr.errmsg,
      code: wr.code.toString(),
      number: wr.codeName,
    );
  }
}
