import 'package:decimal/decimal.dart';
import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';

import 'category.dart';
import 'ingredient.dart';

part 'recipe.g.dart';

@DefaultsProvider(createDefaultsProviderBaseClass: true)
class Recipe {
  final String key;

  final String title;

  final List<Ingredient> ingredients;

  final int numPosts;
  final double doubleNumPosts;
  final Decimal decimalNumPosts;

  final String? runtimeTag;

  final Ingredient mainIngredient;
  final Category category;

  Recipe({
    this.key = '',
    required this.title,
    required this.ingredients,
    this.runtimeTag,
    required this.numPosts,
    required this.doubleNumPosts,
    required this.decimalNumPosts,
    required this.mainIngredient,
    required this.category,
  });
}

class RecipeDefaultsProvider extends RecipeDefaultsProviderBase {
  @override
  Category get category => Category(title: 'my category');
}
