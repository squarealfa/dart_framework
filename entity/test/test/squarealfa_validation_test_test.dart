import 'package:decimal/decimal.dart';
import 'package:squarealfa_validation_test/squarealfa_validation_test.dart';
import 'package:squarealfa_validation_test/src/empty.dart';
import 'package:squarealfa_validation_test/src/ingredient.dart';

import 'package:test/test.dart';

void main() {
  group('main group', () {
    test('no error', () {
      var recipe = Recipe(title: 'something', description: 'something');
      var validator = $RecipeValidator();
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
      var validator = $RecipeValidator();
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
      var validator = $RecipeValidator();
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
      var validator = $RecipeValidator();
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
      var validator = $RecipeValidator();
      var titleError = validator.validateTitle(recipe.title);
      var descritionError = validator.validateDescription(recipe.description);
      var recipeErrors = validator.validate(recipe);

      expect(titleError?.propertyName, 'title');
      expect(descritionError?.propertyName, 'description');
      expect(recipeErrors.validationErrors.length, 2);
      expect(recipeErrors.hasErrors, true);
    });

    test('No range error', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.hasErrors, false);
    });

    test('Description too small', () {
      final ingredient = Ingredient(
        description: '',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'description');
    });

    test('Notes is too big', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        notes: 'this is just too big',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'notes');
    });

    test('too small tag', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        tag: '',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'tag');
    });

    test('too small quantity', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 5,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'quantity');
    });

    test('too big quantity', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 25,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'quantity');
    });

    test('too small precision', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(5),
        quantity: 15,
        intQuantity: 15,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'precision');
    });

    test('too small intQuantity', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 5,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'intQuantity');
    });

    test('too big intQuantity', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 25,
        rInt: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'intQuantity');
    });

    test('missing rInt', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'rInt');
    });

    test('too small rInt', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 5,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'rInt');
    });

    test('too big rInt', () {
      final ingredient = Ingredient(
        description: 'this is big enough',
        precision: Decimal.fromInt(15),
        quantity: 15,
        intQuantity: 15,
        rInt: 25,
      );

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'rInt');
    });

    test('too small nIntQuantity', () {
      final ingredient = Ingredient(
          description: 'this is big enough',
          precision: Decimal.fromInt(15),
          quantity: 15,
          intQuantity: 15,
          rInt: 15,
          nintQuantity: 5);

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'nintQuantity');
    });

    test('too big nIntQuantity', () {
      final ingredient = Ingredient(
          description: 'this is big enough',
          precision: Decimal.fromInt(15),
          quantity: 15,
          intQuantity: 15,
          rInt: 15,
          nintQuantity: 25);

      final validator = $IngredientValidator();
      final errors = validator.validate(ingredient);

      expect(errors.validationErrors.first.propertyName, 'nintQuantity');
    });

    test('too empty', () {
      final empty = Empty();

      final validator = $EmptyValidator();
      final errors = validator.validate(empty);

      expect(errors.validationErrors.isEmpty, true);
    });
  });
}
