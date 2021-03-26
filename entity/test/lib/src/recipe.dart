import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'recipe.g.dart';

@validatable
@builder
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
