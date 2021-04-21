import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_repository/mongo_repository.dart';
import 'package:nosql_repository/src/repository.dart';
import 'package:nosql_repository_tests/nosql_repository_tests.dart';

import 'test_conf.dart';

void main() {
  repositoryTests(MongoRepositoryTestHandler());
}

class MongoRepositoryTestHandler extends RepositoryTestHandler {
  @override
  Future<Repository<Recipe>> createRepositoryForCleanCollection() async {
    final testDbClient = _connectDb(connectionString);
    final mrepo = MongoRepository<Recipe>(testDbClient, 'recipes');
    final repository = MongoRepository<Recipe>(testDbClient, 'recipes');
    await mrepo.entityDb.collection;
    await testDbClient.dropCollection('recipes');
    return repository;
  }

  @override
  String getIdFromMap(Map<String, dynamic> map, [String? fieldName]) {
    fieldName ??= '_id';
    fieldName = mapKeyFieldName(fieldName);
    return (map[fieldName] as ObjectId).toHexString();
  }

  @override
  Map<String, dynamic> toIdMap(String key) => {
        '_id': key.isNotEmpty ? ObjectId.fromHexString(key) : null,
      };

  @override
  String mapKeyFieldName(String keyFieldName) {
    if (keyFieldName == '_key' || keyFieldName == 'key') {
      return '_id';
    }
    if (keyFieldName.endsWith('Key')) {
      return keyFieldName.substring(0, keyFieldName.length - 3) + 'Id';
    }
    return keyFieldName;
  }
}

Db _connectDb(String connectionString) {
  var client = Db(connectionString);

  return client;
}
