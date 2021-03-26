import 'package:squarealfa_validation/squarealfa_validation.dart';

part 'recipe.g.dart';

@validatable
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
