import 'ingredient.dart';

class Recipe {
  final String key;
  final String title;
  final String description; // to be used by the update test
  final List<Ingredient> ingredients;

  Recipe({
    this.key = '',
    required this.title,
    required this.description,
    required this.ingredients,
  });
}
