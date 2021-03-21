import 'db_repository.dart';
import 'principal.dart';
import 'recipe.dart';

void main(List<String> args) async {
  // first, we will create a repository class
  final repository = DbRepository('recipes');

  // first we need to create a principal to represent the
  // user performing the operations to the database
  final principal = Principal('Alice');

  var recipe = Recipe(
    title: 'Scrambled eggs',
    ingredients: ['6 eggs', 'salt', 'pepper', 'milk', 'olive oil'],
    steps: [
      'Whisk all the ingredients',
      'Pour a sliver of olive oil on the pan',
      'Add the mixture to the heated oil',
      'gently mix'
    ],
  );

  var map = _recipeToMap(recipe);

  // this following line will create a new recipe in
  // the database, so long has the 'create_recipe' permission.
  map = await repository.create(map, principal);

  // we will assume that create returns a key in the _key field:
  var key = map['_key'];

  // and with that key we can retrieve the object again from
  // the database by using get
  map = await repository.get(key, principal);

  // which we finally convert again to a Recipe
  recipe = _recipeFromMap(map);
  print(recipe.title);
}

/// Serializes a recipe to a Map<String, dynamic>.
/// This method is dying to be code-generated
Map<String, dynamic> _recipeToMap(Recipe recipe) => {
      'title': recipe.title,
      'ingredients': recipe.ingredients,
      'steps': recipe.steps
    };

/// Deserializes a Recipe from a Map<String, dynamic>.
/// This method is also dying to be code-generated.
Recipe _recipeFromMap(Map<String, dynamic> map) => Recipe(
    title: map['title'], ingredients: map['ingredients'], steps: map['steps']);
