import 'package:arango_driver/arango_driver.dart';
import 'package:arangodb_repository/arangodb_repository.dart';
import 'package:nosql_repository/nosql_repository.dart';

import 'ingredient.dart';
import 'principal.dart';
import 'recipe.dart';

void main(List<String> args) async {
  // first we create a connection to ArangoDB
  final db = _connectArangoDb();

  // now, we create a repository on that connection to the recipes collection.
  final repository = ArangoDbRepository<Recipe>(db, 'recipes');

  // first we need to create a principal to represent the
  // user performing the operations to the database
  final principal = Principal('alice');

  var scrambledEggs = _scrambledEggsRecipe();

  var map = _recipeToMap(scrambledEggs);

  // this following line will create a new recipe in
  // the database, so long has the 'create_recipe' permission.
  map = await repository.create(map, principal);

  // we will assume that create returns a key in the _key field:
  var key = map['_key'];

  // and with that key we can retrieve the object again from
  // the database by using get
  map = await repository.get(key, principal);

  // which we finally convert again to a Recipe
  scrambledEggs = _recipeFromMap(map);
  print(scrambledEggs.title);

  var friedEggs = _friedEggsRecipe();
  map = _recipeToMap(friedEggs);
  map['meta'] = <String, dynamic>{
    'shares': [
      <String, dynamic>{
        'userKey': principal.userKey,
        'actions': ['write', 'read']
      }
    ]
  };
  await repository.create(map, principal);

  final criteria = SearchCriteria(searchConditions: [
    Expression.like('entity.title', '%eggs%'),
  ]);

  // because the user has the 'search_recipes' permission,
  // all records of the same tenant will be returned
  var searchResult = await repository.searchToList(
    criteria,
    principal,
  );
  for (var item in searchResult) {
    print(item.toString());
  }

  // now, we are asking for a search, but this
  // time we will be using a search policy that
  // requires a permission the user does not have
  // to return all recipes. In this case,
  // only, the recipes explicitly shared with the
  // user will be returned, in this case
  // the fried eggs.
  searchResult = await repository.searchToList(
    criteria,
    principal,
    SearchPolicy(permission: 'search_all_recipes'),
  );
  for (var item in searchResult) {
    print(item.toString());
  }
}

Recipe _scrambledEggsRecipe() {
  var recipe = Recipe(
    title: 'Scrambled eggs',
    ingredients: [
      Ingredient(description: 'eggs', quantity: 6.0),
      Ingredient(description: 'salt', quantity: 0.01),
      Ingredient(description: 'milk', quantity: 0.5),
      Ingredient(description: 'olive oil', quantity: 0.02),
    ],
  );
  return recipe;
}

Recipe _friedEggsRecipe() {
  var recipe = Recipe(
    title: 'Fried eggs',
    ingredients: [
      Ingredient(description: 'eggs', quantity: 2.0),
      Ingredient(description: 'salt', quantity: 0.002),
      Ingredient(description: 'olive oil', quantity: 0.02),
    ],
  );
  return recipe;
}

ArangoDBClient _connectArangoDb() {
  var client = ArangoDBClient(
    scheme: 'http',
    host: 'localhost',
    port: 8529,
    db: 'mydatabase',
    user: 'user',
    pass: 'password',
  );
  return client;
}

Map<String, dynamic> _recipeToMap(Recipe recipe) => {
      '_key': recipe.key,
      'title': recipe.title,
      'ingredients': List<Map<String, dynamic>>.from(
          recipe.ingredients.map((e) => _ingredientToMap(e))),
    };

Recipe _recipeFromMap(Map<String, dynamic> map) {
  return Recipe(
    key: map['_key'],
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
