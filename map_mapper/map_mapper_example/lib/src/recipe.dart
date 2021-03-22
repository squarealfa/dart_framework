import 'package:map_mapper_annotations/map_mapper_annotations.dart';

import 'ingredient.dart';

part 'recipe.g.dart';

@mapMap
class Recipe {
  final String key;

  // map to 'ptitle' map entry
  @MapField(name: 'ptitle')
  final String title;

  // by default all public non-static properties are generated
  // so, this list is also generated. Take care to decorate the
  // [Ingredient] class with @mapMap
  final List<Ingredient> ingredients;

  // do not map this field
  @mapIgnore
  final String? runtimeTag;

  Recipe(
      {this.key = '',
      required this.title,
      required this.ingredients,
      this.runtimeTag});
}
