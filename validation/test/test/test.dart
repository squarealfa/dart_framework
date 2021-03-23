import 'package:test/test.dart';

import '../lib/map_mapper_generator_test.dart';

void main() {
  group('main group', () {
    test('no error', () {
      var recipe = Recipe(title: 'something', description: 'something');
      var validator = RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError, null);
      expect(descritionError, null);
      expect(recipeErrors.validationErrors.isEmpty, true);
      expect(recipeErrors.hasErrors, false);
    });

    test('missing title', () {
      var recipe = Recipe(title: '', description: 'something');
      var validator = RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError?.propertyName, 'title');
      expect(descritionError, null);
      expect(recipeErrors.validationErrors.first.propertyName, 'title');
      expect(recipeErrors.validationErrors.length, 1);
      expect(recipeErrors.hasErrors, true);
    });

    test('null description', () {
      var recipe = Recipe(title: 'something', description: null);
      var validator = RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError, null);
      expect(descritionError?.propertyName, 'description');
      expect(recipeErrors.validationErrors.first.propertyName, 'description');
      expect(recipeErrors.validationErrors.length, 1);
      expect(recipeErrors.hasErrors, true);
    });

    test('empty description', () {
      var recipe = Recipe(title: 'something', description: '');
      var validator = RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError, null);
      expect(descritionError?.propertyName, 'description');
      expect(recipeErrors.validationErrors.first.propertyName, 'description');
      expect(recipeErrors.validationErrors.length, 1);
      expect(recipeErrors.hasErrors, true);
    });

    test('missing title and description', () {
      var recipe = Recipe(title: '', description: null);
      var validator = RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError?.propertyName, 'title');
      expect(descritionError?.propertyName, 'description');
      expect(recipeErrors.validationErrors.length, 2);
      expect(recipeErrors.hasErrors, true);
    });
  });
}
