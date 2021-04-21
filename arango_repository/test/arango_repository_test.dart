import 'package:arango_driver/arango_driver.dart';
import 'package:arangodb_repository/arangodb_repository.dart';
import 'package:nosql_repository/src/repository.dart';
import 'package:nosql_repository_tests/nosql_repository_tests.dart';
import 'package:nosql_repository_tests/src/recipe.dart';

import 'test_conf.dart';

void main() {
  repositoryTests(ArangoRepositoryTestHandler());
}

class ArangoRepositoryTestHandler extends RepositoryTestHandler {
  @override
  Future<Repository<Recipe>> createRepositoryForCleanCollection() async {
    final testDbClient = await _connectTestDb();
    await _ensureEmptyTestCollection(testDbClient, 'recipes');
    final repository = ArangoDbRepository<Recipe>(testDbClient, 'recipes');
    return repository;
  }

  @override
  String getIdFromMap(Map<String, dynamic> map) {
    return map['_key'];
  }

  @override
  Map<String, dynamic> toIdMap(String key) {
    return {'_key': key};
  }
}

Future _ensureEmptyTestCollection(
    ArangoDBClient testDbClient, String testCollection) async {
  var allCollectionsAnsw = await testDbClient.allCollections();
  var alreadyExists =
      allCollectionsAnsw.response!.any((coll) => coll.name == testCollection);
  if (!alreadyExists) {
    var answer = await testDbClient.createCollection(
      name: testCollection,
    );
    if (answer.result.error) {
      throw Error();
    }
  }
  if ((await testDbClient.truncateCollection(testCollection)).result.error) {
    throw Error();
  }
}

Future<ArangoDBClient> _connectTestDb() async {
  const systemDb = '_system';
  const testDb = 'test_temp_db';
  var clientSystemDb = _connectArangoDb(systemDb);
  var databases = await clientSystemDb.existingDatabases();
  // skip test if test database already exists
  if (!databases.response!.contains(testDb)) {
    var result = await clientSystemDb
        .createDatabase(CreateDatabaseInfo(testDb, [DatabaseUser('u', 'ps')]));
    if (result.result.error) {
      throw Error();
    }
  }
  final testDbClient = _connectArangoDb(testDb);

  return testDbClient;
}

ArangoDBClient _connectArangoDb(String db) {
  var client = ArangoDBClient(
    scheme: dbscheme,
    host: dbhost,
    port: dbport,
    db: db,
    user: dbuser,
    pass: dbpass,
  );
  return client;
}
