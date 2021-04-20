import 'package:arango_driver/arango_driver.dart';
import 'package:arangodb_repository/arangodb_repository.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:test/test.dart';

import 'ingredient.dart';
import 'principal.dart';
import 'recipe.dart';
import 'test_conf.dart';

const _testCollection = 'recipes';
const _testUsername = 'alice';
const _thirdUsername = 'bob';
const _thirdTenantKey = 'acme';

void main() {
  group('client can', () {
    Repository<Recipe>? repository;
    final principal = Principal(_testUsername);
    final thirdPrincipal = Principal(_thirdUsername, _thirdTenantKey);

    setUp(() async {
      final testDbClient = await _connectTestDb();
      await _ensureEmptyTestCollection(testDbClient, _testCollection);
      repository = ArangoDbRepository<Recipe>(testDbClient, _testCollection);
    });

    test('insert entity', () async {
      final insertedKey = await _createScrambledEggs(repository!, principal);
      expect(insertedKey, isNotEmpty);
    });

    test('read entity', () async {
      final insertedKey = await _createScrambledEggs(repository!, principal);
      var map = await repository!.get(insertedKey, principal);

      var recipe = _recipeFromMap(map);
      expect(recipe.title, 'Scrambled eggs');
      expect(recipe.key, insertedKey);
    });

    test('update entity', () async {
      final insertedKey = await _createScrambledEggs(repository!, principal);
      var map = await repository!.get(insertedKey, principal);

      var recipe = _recipeFromMap(map);
      recipe = Recipe(
        key: recipe.key,
        title: recipe.title,
        time: recipe.time,
        description: 'updated description',
        ingredients: recipe.ingredients,
      );

      map = _recipeToMap(recipe);

      await repository!.update(map, principal);
      map = await repository!.get(insertedKey, principal);
      recipe = _recipeFromMap(map);

      expect(recipe.description, 'updated description');
    });

    test('search entity', () async {
      final insertedKey = await _createScrambledEggs(repository!, principal);
      final criteria = SearchCriteria(searchConditions: [
        Equal.fieldValue('entity.title', 'Scrambled eggs')
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.first['_key'], insertedKey);
    });

    test('search not found', () async {
      await _createScrambledEggs(repository!, principal);
      final criteria = SearchCriteria(searchConditions: [
        Equal.fieldValue('entity.title', 'unscrambled eggs')
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult, isEmpty);
    });

    test('getAll', () async {
      final insertedKey = await _createScrambledEggs(repository!, principal);
      var searchResult = await repository!.getAllToList(
        principal,
      );

      expect(searchResult.first['_key'], insertedKey);
    });

    test('search entity with action filter', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('entity.title', '%eggs%'),
      ]);

      var filteredSearchResult = await repository!.searchToList(
        criteria,
        principal,
        SearchPolicy(permission: 'non-existent'),
      );

      var filteredSearchResult2 = await repository!.searchToList(
        criteria,
        principal,
        // the same as passing SearchPolicy(permission: 'search_recipes')
      );

      var unfilteredSearchResult = await repository!.searchToList(
        criteria,
        principal,
        SearchPolicy(permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 1);
      expect(filteredSearchResult2.length, 2);
      expect(unfilteredSearchResult.length, 2);
    });

    test('get all with action filter', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      var filteredSearchResult = await repository!.getAllToList(
        principal,
        SearchPolicy(permission: 'non-existent'),
      );

      var filteredSearchResult2 = await repository!.getAllToList(
        principal,
        // the same as passing SearchPolicy(permission: 'search_recipes')
      );

      var unfilteredSearchResult = await repository!.getAllToList(
        principal,
        SearchPolicy(permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 1);
      expect(filteredSearchResult2.length, 2);
      expect(unfilteredSearchResult.length, 2);
    });

    test('search entity with third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal, thirdPrincipal]);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('entity.title', '%eggs%'),
      ]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
        SearchPolicy(),
      );

      var unfilteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
      );

      expect(filteredSearchResult.length, 0);
      expect(unfilteredSearchResult.length, 0);
    });

    test('getAll with third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal, thirdPrincipal]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
        SearchPolicy(),
      );

      var unfilteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
      );

      expect(filteredSearchResult.length, 0);
      expect(unfilteredSearchResult.length, 0);
    });

    test('search entity with unfiltered third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal, thirdPrincipal]);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('entity.title', '%eggs%'),
      ]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
        SearchPolicy(
          permission: 'non-existent',
          filterByTenant: false,
        ),
      );

      var unfilteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
        SearchPolicy(filterByTenant: false, permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 1);
      expect(unfilteredSearchResult.length, 2);
    });

    test('getAll with unfiltered third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal, thirdPrincipal]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
        SearchPolicy(
          permission: 'non-existent',
          filterByTenant: false,
        ),
      );

      var unfilteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
        SearchPolicy(filterByTenant: false, permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 1);
      expect(unfilteredSearchResult.length, 2);
    });

    test('search entity with unfiltered, unshared, third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('entity.title', '%eggs%'),
      ]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
        SearchPolicy(
          permission: 'non-existent',
          filterByTenant: false,
        ),
      );

      var unfilteredSearchResult = await repository!.searchToList(
        criteria,
        thirdPrincipal,
        SearchPolicy(filterByTenant: false, permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 0);
      expect(unfilteredSearchResult.length, 2);
    });

    test('getAll with unfiltered, unshared, third principal', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      // because the user has the 'search_recipes' permission,
      // all records of the same tenant will be returned
      var filteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
        SearchPolicy(
          permission: 'non-existent',
          filterByTenant: false,
        ),
      );

      var unfilteredSearchResult = await repository!.getAllToList(
        thirdPrincipal,
        SearchPolicy(filterByTenant: false, permission: 'search_recipes'),
      );

      expect(filteredSearchResult.length, 0);
      expect(unfilteredSearchResult.length, 2);
    });

    test('test And expression', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        And(
          Like.fieldValue('entity.title', '%eggs%'),
          Like.fieldValue('entity.description', '%fried%'),
        )
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test implicit And expression', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('entity.title', '%eggs%'),
        Like.fieldValue('entity.description', '%fried%'),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test not expression', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        Not(
          Like.fieldValue('entity.title', '%Scrambled%'),
        ),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test in expression', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        In(FieldPath('entity.title'),
            ListInput(['Steak', 'Fried eggs', 'Cake']))
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test greaterthan', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        GreaterThan(FieldPath('entity.time'), Input(5)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Scrambled eggs');
    });

    test('test greater or equal than', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        GreaterOrEqualThan(FieldPath('entity.time'), Input(5)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 2);
    });

    test('test less than', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        LessThan(FieldPath('entity.time'), Input(10)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test less or equal than', () async {
      await _createScrambledEggs(repository!, principal);
      await _createFriedEggs(repository!, [principal]);

      final criteria = SearchCriteria(searchConditions: [
        LessOrEqualThan(FieldPath('entity.time'), Input(10)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 2);
    });
    // end of group
  });
}

Future<String> _createScrambledEggs(
  Repository<Recipe> repository,
  Principal principal,
) async {
  final recipe = _scrambledEggs();
  var map = _recipeToMap(recipe);
  map = await repository.create(map, principal);
  final insertedKey = map['_key'];
  return insertedKey;
}

Future _createFriedEggs(
  Repository<Recipe> repository,
  List<Principal> principals,
) async {
  final friedEggs = _friedEggsRecipe();

  final map = _recipeToMap(friedEggs);
  map['meta'] = <String, dynamic>{
    'shares': [
      for (final principal in principals)
        <String, dynamic>{
          'userKey': principal.userKey,
          'actions': ['write', 'read']
        }
    ]
  };

  await repository.create(map, principals.first);
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

Recipe _scrambledEggs() {
  return Recipe(
    title: 'Scrambled eggs',
    description: 'simple scrambled eggs recipe',
    time: 10,
    ingredients: [
      Ingredient(description: 'eggs', quantity: 6.0),
      Ingredient(description: 'salt', quantity: 0.01),
      Ingredient(description: 'milk', quantity: 0.5),
      Ingredient(description: 'olive oil', quantity: 0.02),
    ],
  );
}

Recipe _friedEggsRecipe() {
  var recipe = Recipe(
    title: 'Fried eggs',
    description: 'simple fried eggs recipe',
    time: 5,
    ingredients: [
      Ingredient(description: 'eggs', quantity: 2.0),
      Ingredient(description: 'salt', quantity: 0.002),
      Ingredient(description: 'olive oil', quantity: 0.02),
    ],
  );
  return recipe;
}

Map<String, dynamic> _recipeToMap(Recipe recipe) => {
      '_key': recipe.key,
      'title': recipe.title,
      'description': recipe.description,
      'time': recipe.time,
      'ingredients':
          recipe.ingredients.map((e) => _ingredientToMap(e)).toList(),
    };

Recipe _recipeFromMap(Map<String, dynamic> map) {
  return Recipe(
    key: map['_key'],
    title: map['title'],
    description: map['description'],
    time: map['time'],
    ingredients: List<Ingredient>.from(
        map['ingredients'].map((e) => _ingredientFromMap(e))),
  );
}

Ingredient _ingredientFromMap(Map<String, dynamic> map) => Ingredient(
    description: map['description'], quantity: map['quantity'].toDouble());

Map<String, dynamic> _ingredientToMap(Ingredient value) => <String, dynamic>{
      'description': value.description,
      'quantity': value.quantity,
    };
