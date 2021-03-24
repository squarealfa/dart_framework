import 'package:map_mapper_example/src/ingredient.dart';
import 'package:map_mapper_example/src/recipe.dart';

void main(List<String> args) {
  final recipe = Recipe(
    title: 'Scrambled eggs',
    ingredients: [
      Ingredient(
        description: 'eggs',
        quantity: 3,
      ),
      Ingredient(
        description: 'bacon',
        quantity: 1,
      ),
      Ingredient(
        description: 'milk',
        quantity: 0.2,
      ),
    ],
  );

  // here we map from the recipe to a Map<String, dynamic>
  final recipeMap = recipe.toMap();

  // and here, we use the extension on Map<String, dynamic> to
  // map it back to a new Recipe instance.
  final receivedRecipe = recipeMap.toRecipe();

  print(' ${receivedRecipe.title} is expected to be Scrambled eggs');
}
