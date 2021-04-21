part of 'repository_test.dart';

Future<Map<String, dynamic>> _createScrambledEggs(
  Repository<Recipe> repository,
  Principal principal,
  RepositoryTestHandler handler, {
  String? title,
}) async {
  final recipe = _scrambledEggs(title: title);
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

Recipe _scrambledEggs({String? title}) {
  return Recipe(
    title: title ?? 'Scrambled eggs',
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
