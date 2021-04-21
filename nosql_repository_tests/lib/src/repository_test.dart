import 'package:nosql_repository/nosql_repository.dart';
import 'package:test/test.dart';

import 'ingredient.dart';
import 'principal.dart';
import 'recipe.dart';

const _testUsername = 'alice';
const _thirdUsername = 'bob';
const _thirdTenantKey = '607fe42698b65b55e497cee3';

abstract class RepositoryTestHandler {
  Future<Repository<Recipe>> createRepositoryForCleanCollection();
  String getIdFromMap(Map<String, dynamic> map);
  Map<String, dynamic> toIdMap(String key);
}

void repositoryTests(RepositoryTestHandler handler) {
  group('client can', () {
    Repository<Recipe>? repository;
    final principal = Principal(_testUsername);
    final thirdPrincipal = Principal(_thirdUsername, _thirdTenantKey);

    setUp(() async {
      repository = await handler.createRepositoryForCleanCollection();
    });

    test('insert entity', () async {
      final insertedMap =
          await _createScrambledEggs(repository!, principal, handler);
      final insertedKey = handler.getIdFromMap(insertedMap);
      expect(insertedKey, isNotEmpty);
    });

    test('read entity', () async {
      final insertedMap =
          await _createScrambledEggs(repository!, principal, handler);
      final insertedKey = handler.getIdFromMap(insertedMap);
      var map = await repository!.get(insertedKey, principal);

      var recipe = _recipeFromMap(map, handler);
      expect(recipe.title, 'Scrambled eggs');
      expect(recipe.key, insertedKey);
    });

    test('update entity', () async {
      final insertedMap =
          await _createScrambledEggs(repository!, principal, handler);
      final insertedKey = handler.getIdFromMap(insertedMap);
      var map = await repository!.get(insertedKey, principal);

      var recipe = _recipeFromMap(map, handler);
      recipe = Recipe(
        key: recipe.key,
        title: recipe.title,
        time: recipe.time,
        description: 'updated description',
        ingredients: recipe.ingredients,
      );

      map = _recipeToMap(recipe, handler);

      await repository!.update(map, principal);
      map = await repository!.get(insertedKey, principal);
      recipe = _recipeFromMap(map, handler);

      expect(recipe.description, 'updated description');
    });

    test('search entity', () async {
      final insertedMap =
          await _createScrambledEggs(repository!, principal, handler);
      final insertedKey = handler.getIdFromMap(insertedMap);
      final criteria = SearchCriteria(
          searchConditions: [Equal.fieldValue('title', 'Scrambled eggs')]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(handler.getIdFromMap(searchResult.first), insertedKey);
    });

    test('test not equal', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(
          searchConditions: [NotEqual.fieldValue('title', 'Scrambled eggs')]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('search not found', () async {
      await _createScrambledEggs(repository!, principal, handler);
      final criteria = SearchCriteria(
          searchConditions: [Equal.fieldValue('title', 'unscrambled eggs')]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult, isEmpty);
    });

    test('getAll', () async {
      final insertedMap =
          await _createScrambledEggs(repository!, principal, handler);
      final insertedKey = handler.getIdFromMap(insertedMap);
      var searchResult = await repository!.getAllToList(
        principal,
      );

      expect(handler.getIdFromMap(searchResult.first), insertedKey);
    });

    test('test like', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('title', '%eggs%'),
      ]);

      var filteredSearchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      final criteria2 = SearchCriteria(searchConditions: [
        Expression.like('title', '%ried%'),
      ]);

      var searchResult2 = await repository!.searchToList(
        criteria2,
        principal,
      );

      expect(filteredSearchResult.length, 2);
      expect(searchResult2.length, 1);
      expect(searchResult2.first['title'], 'Fried eggs');
    });

    test('search entity with action filter', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('title', '%eggs%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal, thirdPrincipal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('title', '%eggs%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal, thirdPrincipal], handler);

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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal, thirdPrincipal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('title', '%eggs%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal, thirdPrincipal], handler);

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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Expression.like('title', '%eggs%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        And(
          Like.fieldValue('title', '%eggs%'),
          Like.fieldValue('description', '%fried%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', '%eggs%'),
        Like.fieldValue('description', '%fried%'),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test not expression', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        Not(
          Like.fieldValue('title', '%Scrambled%'),
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
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        In(FieldPath('title'), ListInput(['Steak', 'Fried eggs', 'Cake']))
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test greaterthan', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        GreaterThan(FieldPath('time'), Input(5)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Scrambled eggs');
    });

    test('test greater or equal than', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        GreaterOrEqualThan(FieldPath('time'), Input(5)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 2);
    });

    test('test less than', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        LessThan(FieldPath('time'), Input(10)),
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 1);
      expect(searchResult.first['title'], 'Fried eggs');
    });

    test('test less or equal than', () async {
      await _createScrambledEggs(repository!, principal, handler);
      await _createFriedEggs(repository!, [principal], handler);

      final criteria = SearchCriteria(searchConditions: [
        LessOrEqualThan(FieldPath('time'), Input(10)),
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

Future<Map<String, dynamic>> _createScrambledEggs(Repository<Recipe> repository,
    Principal principal, RepositoryTestHandler handler) async {
  final recipe = _scrambledEggs();
  var map = _recipeToMap(recipe, handler);
  map = await repository.create(map, principal);
  return map;
}

Future _createFriedEggs(
  Repository<Recipe> repository,
  List<Principal> principals,
  RepositoryTestHandler handler,
) async {
  final friedEggs = _friedEggsRecipe();

  final map = _recipeToMap(friedEggs, handler);
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

Map<String, dynamic> _recipeToMap(
        Recipe recipe, RepositoryTestHandler handler) =>
    {
      ...handler.toIdMap(recipe.key),
      'title': recipe.title,
      'description': recipe.description,
      'time': recipe.time,
      'ingredients':
          recipe.ingredients.map((e) => _ingredientToMap(e)).toList(),
    };

Recipe _recipeFromMap(Map<String, dynamic> map, RepositoryTestHandler handler) {
  return Recipe(
    key: handler.getIdFromMap(map),
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
