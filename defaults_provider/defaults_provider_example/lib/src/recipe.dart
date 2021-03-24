import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';

import 'ingredient.dart';

part 'recipe.g.dart';

@defaultsProvider
class Recipe {
  final String key;

  final String title;

  final List<Ingredient> ingredients;

  final String? runtimeTag;

  Recipe({
    this.key = '',
    required this.title,
    required this.ingredients,
    this.runtimeTag,
  });
}
