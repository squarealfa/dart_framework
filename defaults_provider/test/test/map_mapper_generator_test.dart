//import 'package:decimal/decimal.dart';
import 'package:decimal/decimal.dart';
import 'package:map_mapper_generator_test/defaults_provider_generator_test.dart';
import 'package:map_mapper_generator_test/src/all_nullable.dart';
import 'package:test/test.dart';

void main() {
  group('basic test', () {
    test('Test Strings', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      expect(recipe.key, '');
      expect(recipe.title, '');
    });

    test('Test List', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      expect(recipe.ingredients, []);
    });

    test('Test int', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      expect(recipe.numPosts, 0);
    });

    test('Test double', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      expect(recipe.doubleNumPosts, 0.0);
    });

    test('Test decimal', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      expect(recipe.decimalNumPosts, Decimal.zero);
    });

    test('Test recursion default', () {
      var defaultsProvider = RecipeDefaultsProvider();
      var ingredientDefaultsProvider = IngredientDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();
      final defaultIngredient = ingredientDefaultsProvider.createWithDefaults();
      expect(recipe.mainIngredient.description, defaultIngredient.description);
      expect(recipe.mainIngredient.quantity, defaultIngredient.quantity);
    });

    test('Test override', () {
      var defaultsProvider = RecipeDefaultsProvider();

      final recipe = defaultsProvider.createWithDefaults();

      expect(recipe.category.title, 'my category');
    });

    test('Test all nullable', () {
      var defaultsProvider = AllNullableDefaultsProvider();

      final an = defaultsProvider.createWithDefaults();

      expect(an.prop1, isNull);
      expect(an.prop2, isNull);
    });
  });
}
