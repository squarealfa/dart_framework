import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_repository/mongo_repository.dart';
import 'package:nosql_repository/nosql_repository.dart';
//import 'package:nosql_repository/nosql_repository.dart';
import 'package:test/test.dart';

import 'ingredient.dart';
import 'principal.dart';
import 'recipe.dart';
import 'test_conf.dart';

const _testCollection = 'recipes';
const _testUsername = 'alice';

void main() async {
  final testDbClient = _connectDb(connectionString);

  final repository = MongoRepository<Recipe>(testDbClient, _testCollection);
  await repository.entityDb.collection;
  await testDbClient.dropCollection(_testCollection);

  final principal = Principal(_testUsername);
  var insertedKey = '';

  group('client can', () {
    test('insert entity', () async {
      var recipe = _scrambledEggs();
      var map = _recipeToMap(recipe);
      map = await repository.create(map, principal);
      insertedKey = (map['_id'] as ObjectId).toHexString();
      expect(insertedKey, isNotNull);
    });

    test('read entity', () async {
      var map = await repository.get(insertedKey, principal);

      var recipe = _recipeFromMap(map);
      expect(recipe.title, 'Scrambled eggs');
      expect(recipe.key, insertedKey);
    });

    test('update entity', () async {
      var map = await repository.get(insertedKey, principal);

      var recipe = _recipeFromMap(map);
      recipe = Recipe(
        key: recipe.key,
        title: 'Updated scrambled eggs',
        ingredients: recipe.ingredients,
      );

      map = _recipeToMap(recipe);

      await repository.update(map, principal);
      map = await repository.get(insertedKey, principal);
      recipe = _recipeFromMap(map);

      expect(recipe.title, 'Updated scrambled eggs');
    });

    // test('search entity', () async {
    //   final criteria = SearchCriteria(searchConditions: [
    //     Equal.fieldValue('entity.title', 'Updated scrambled eggs')
    //   ]);
    //   var searchResult = await repository
    //       .search(
    //         criteria,
    //         principal,
    //       )
    //       .toList();

    //   expect(searchResult.first['_key'], insertedKey);
    // });

    // test('search entity with action filter', () async {
    //   final friedEggs = _friedEggsRecipe();

    //   var map = _recipeToMap(friedEggs);
    //   map['meta'] = <String, dynamic>{
    //     'shares': [
    //       <String, dynamic>{
    //         'userKey': principal.userKey,
    //         'actions': ['write', 'read']
    //       }
    //     ]
    //   };

    //   await repository.create(map, principal);

    //   final criteria = SearchCriteria(searchConditions: [
    //     Expression.like('entity.title', '%eggs%'),
    //   ]);

    //   // because the user has the 'search_recipes' permission,
    //   // all records of the same tenant will be returned
    //   var filteredSearchResult = await repository
    //       .search(
    //         criteria,
    //         principal,
    //         SearchPolicy(permission: 'search_all_recipes'),
    //       )
    //       .toList();

    //   var unfilteredSearchResult = await repository
    //       .search(
    //         criteria,
    //         principal,
    //       )
    //       .toList();

    //   expect(filteredSearchResult.length, 1);
    //   expect(unfilteredSearchResult.length, 2);
    // });

    test('delete entity', () async {
      await repository.delete(insertedKey, principal);

      expect(() async {
        await repository.get(insertedKey, principal);
      }, throwsA(isA<DbException>()));
      //expect();
    });

    // end of group
  });
}

// Future _ensureEmptyTestCollection(
//     ArangoDBClient testDbClient, String testCollection) async {
//   var allCollectionsAnsw = await testDbClient.allCollections();
//   var alreadyExists =
//       allCollectionsAnsw.response!.any((coll) =>
//  coll.name == testCollection);
//   if (!alreadyExists) {
//     var answer = await testDbClient.createCollection(
//       name: testCollection,
//     );
//     if (answer.result.error) {
//       throw Error();
//     }
//   }
//   if ((await testDbClient.truncateCollection(testCollection)).result.error) {
//     throw Error();
//   }
// }

// Future<ArangoDBClient> _connectTestDb() async {
//   const systemDb = '_system';
//   const testDb = 'test_temp_db';
//   var clientSystemDb = _connectDb(systemDb);
//   var databases = await clientSystemDb.existingDatabases();
//   // skip test if test database already exists
//   if (!databases.response!.contains(testDb)) {
//     var result = await clientSystemDb
//         .createDatabase(CreateDatabaseInfo(testDb,
// [DatabaseUser('u', 'ps')]));
//     if (result.result.error) {
//       throw Error();
//     }
//   }
//   final testDbClient = _connectDb(testDb);
//   await _ensureEmptyTestCollection(testDbClient, _testCollection);

//   return testDbClient;
// }

Db _connectDb(String connectionString) {
  var client = Db(connectionString);

  return client;
}

Recipe _scrambledEggs() {
  return Recipe(
    title: 'Scrambled eggs',
    ingredients: [
      Ingredient(description: 'eggs', quantity: 6.0),
      Ingredient(description: 'salt', quantity: 0.01),
      Ingredient(description: 'milk', quantity: 0.5),
      Ingredient(description: 'olive oil', quantity: 0.02),
    ],
  );
}

// Recipe _friedEggsRecipe() {
//   var recipe = Recipe(
//     title: 'Fried eggs',
//     ingredients: [
//       Ingredient(description: 'eggs', quantity: 2.0),
//       Ingredient(description: 'salt', quantity: 0.002),
//       Ingredient(description: 'olive oil', quantity: 0.02),
//     ],
//   );
//   return recipe;
// }
//

Map<String, dynamic> _recipeToMap(Recipe recipe) => {
      '_id': recipe.key.isNotEmpty ? ObjectId.fromHexString(recipe.key) : null,
      'title': recipe.title,
      'ingredients':
          recipe.ingredients.map((e) => _ingredientToMap(e)).toList(),
    };

Recipe _recipeFromMap(Map<String, dynamic> map) {
  return Recipe(
    key: (map['_id'] as ObjectId).toHexString(),
    title: map['title'],
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
