import 'package:squarealfa_validation/squarealfa_validation.dart';

part 'example.g.dart';

@validatable
class Recipe {
  @required
  final String title;

  Recipe({
    required this.title,
  });
}
