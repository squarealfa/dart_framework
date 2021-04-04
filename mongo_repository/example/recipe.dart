import 'ingredient.dart';

class Recipe {
  final String key;
  final String title;
  final List<Ingredient> ingredients;

  Recipe({
    this.key = '',
    required this.title,
    required this.ingredients,
  });
}
