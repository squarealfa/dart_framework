import 'package:squarealfa_validation_example/squarealfa_validation_example.dart';

void main() {
  var recipe = Recipe(title: '', description: null);
  var validator = RecipeValidator();

  var errors = validator.validate(recipe);

  for (var error in errors.validationErrors) {
    print(error);
  }
}
