import 'package:nosql_repository/nosql_repository.dart';
import 'package:test/test.dart';

import 'ingredient.dart';
import 'principal.dart';
import 'recipe.dart';
import 'repository_test_handler.dart';

part 'test_helper.dart';

const _testUsername = 'alice';
const _thirdUsername = 'bob';
const _thirdTenantKey = '607fe42698b65b55e497cee3';

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

    test('search big batch', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(
          searchConditions: [Like.fieldValue('title', 'recipe number %')]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 200);
    });

    test('test order by', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', 'recipe number %'),
      ], orderByFields: [
        OrderBy('title')
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 200);
      expect(searchResult[2]['title'], 'recipe number 10');
    });

    test('test order by descending', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', 'recipe number %'),
      ], orderByFields: [
        OrderBy('title', isDescending: true)
      ]);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 200);
      expect(searchResult.first['title'], 'recipe number 99');
    });

    test('test skip', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', 'recipe number %'),
      ], orderByFields: [
        OrderBy('title', isDescending: true)
      ], skip: 20);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 180);
      expect(searchResult.first['title'], 'recipe number 80');
    });

    test('test take', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', 'recipe number %'),
      ], orderByFields: [
        OrderBy('title', isDescending: true)
      ], take: 15);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 15);
      expect(searchResult.first['title'], 'recipe number 99');
      expect(searchResult.last['title'], 'recipe number 86');
    });

    test('test skip and take', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(searchConditions: [
        Like.fieldValue('title', 'recipe number %'),
      ], orderByFields: [
        OrderBy('title', isDescending: true)
      ], skip: 120, take: 25);
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      expect(searchResult.length, 25);
      expect(searchResult.first['title'], 'recipe number 17');
      expect(searchResult.last['title'], 'recipe number 148');
    });

    test('test projection', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(
        searchConditions: [
          Like.fieldValue('title', 'recipe number %'),
        ],
        orderByFields: [OrderBy('title', isDescending: true)],
        skip: 120,
        take: 25,
        returnFields: [
          ReturnField('title'),
          ReturnField('time', 'minutes'),
          ReturnField('meta.tenantKey'),
          ReturnField('meta.tenantKey', 'tk')
        ],
      );
      var searchResult = await repository!.searchToList(
        criteria,
        principal,
      );

      final second = searchResult[1];
      final secondKeys = second.keys.toList();

      expect(searchResult.length, 25);
      expect(searchResult.first['title'], 'recipe number 17');
      expect(searchResult.last['title'], 'recipe number 148');
      expect(second.keys.length, 4);
      expect(secondKeys[0], 'title');
      expect(secondKeys[1], 'minutes');
      expect(secondKeys[2], 'meta_tenantKey');
      expect(secondKeys[3], 'tk');
      expect(second['title'], 'recipe number 169');
      expect(second['minutes'], 10);
      expect(second['meta_tenantKey'], '607f866f98b65b55e497cee0');
      expect(second['tk'], '607f866f98b65b55e497cee0');
    });

    test('search with count only', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(
        searchConditions: [
          Like.fieldValue('title', 'recipe number %'),
        ],
        orderByFields: [OrderBy('title', isDescending: true)],
        skip: 120,
        take: 25,
        returnFields: [
          ReturnField('title'),
          ReturnField('time', 'minutes'),
          ReturnField('meta.tenantKey'),
          ReturnField('meta.tenantKey', 'tk')
        ],
      );
      var cnt = await repository!.count(
        criteria,
        principal,
      );

      expect(cnt, 200);
    });

    test('search with count', () async {
      for (var i = 0; i < 200; i++) {
        await _createScrambledEggs(repository!, principal, handler,
            title: 'recipe number $i');
      }

      final criteria = SearchCriteria(
        searchConditions: [
          Like.fieldValue('title', 'recipe number %'),
        ],
        orderByFields: [OrderBy('title', isDescending: true)],
        skip: 120,
        take: 25,
        returnFields: [
          ReturnField('title'),
          ReturnField('time', 'minutes'),
          ReturnField('meta.tenantKey'),
          ReturnField('meta.tenantKey', 'tk')
        ],
      );
      var srCount = await repository!.searchWithCount(
        criteria,
        principal,
      );

      final searchResult = await srCount.page.toList();

      final cnt = srCount.count;
      final second = searchResult[1];
      final secondKeys = second.keys.toList();

      expect(cnt, 200);

      expect(searchResult.length, 25);
      expect(searchResult.first['title'], 'recipe number 17');
      expect(searchResult.last['title'], 'recipe number 148');
      expect(second.keys.length, 4);
      expect(secondKeys[0], 'title');
      expect(secondKeys[1], 'minutes');
      expect(secondKeys[2], 'meta_tenantKey');
      expect(secondKeys[3], 'tk');
      expect(second['title'], 'recipe number 169');
      expect(second['minutes'], 10);
      expect(second['meta_tenantKey'], '607f866f98b65b55e497cee0');
      expect(second['tk'], '607f866f98b65b55e497cee0');
    });

    // end of group
  });
}
