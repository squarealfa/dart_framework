import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import 'category.dart';

part 'recipe.g.dart';

@validatable
@builder
@copyWith
class Recipe {
  @required
  final String title;

  @required
  final String? description;

  Recipe({
    required this.title,
    this.description,
  });
}
