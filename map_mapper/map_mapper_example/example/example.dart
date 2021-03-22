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

  /// protoRecipe is a proto class, which
  /// could be returned as a gRPC service
  /// return type. To map from the
  /// Recipe class to its corresponding proto
  /// class, the toProto is used.
  final recipeMap = recipe.toMap();

  /// When a gRPC receives a protoRecipe as
  /// a parameter, it can be mapped back to
  /// an instance of a Recipe class using the
  /// toRecipe() method.
  final receivedRecipe = recipeMap.toRecipe();

  print(' ${receivedRecipe.title} is expected to be Scrambled eggs');
}
