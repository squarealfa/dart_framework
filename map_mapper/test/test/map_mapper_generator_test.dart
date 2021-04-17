import 'package:decimal/decimal.dart';
import 'package:map_mapper_generator_test/map_mapper_generator_test.dart';
import 'package:test/test.dart';

void main() {
  group('basic test', () {
    test('category roundtrip', () {
      var category = Category(
        title: 'eggs',
        mainComponent: Component(description: ''),
        otherComponents: [],
      );

      var pcategory = category.toMap();
      var category2 = pcategory.toCategory();

      expect(category2.title, 'eggs');
    });

    test('publish date', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.publishDate, recipe.publishDate);
    });

    test('null expiry date', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.expiryDate, recipe.expiryDate);
    });

    test('non-null expiry date', () {
      final recipe =
          _scrambledEggsRecipe(expiryDate: DateTime(2020, 02, 28, 22, 15, 20));

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.expiryDate, recipe.expiryDate);
    });

    test('ingredient.duration property', () {
      var ingredient = Ingredient(
        description: '',
        quantity: Decimal.fromInt(0),
        precision: 0.0,
        cookingDuration: Duration(
            days: 5602, hours: 21, minutes: 44, seconds: 22, milliseconds: 12),
        mainComponent: Component(description: ''),
        otherComponents: [],
      );

      var pIngredient = ingredient.toMap();
      var ingredient2 = pIngredient.toIngredient();

      expect(ingredient2.cookingDuration, ingredient.cookingDuration);
    });

    test('preparation duration', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.preparationDuration, recipe.preparationDuration);
    });

    test('null total duration', () {
      final recipe = _scrambledEggsRecipe(totalDuration: null);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.totalDuration, recipe.totalDuration);
    });

    test('non-null total duration', () {
      final recipe =
          _scrambledEggsRecipe(totalDuration: Duration(hours: 1, minutes: 5));

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.totalDuration, recipe.totalDuration);
    });

    test('isPublished', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.isPublished, recipe.isPublished);
    });

    test('null requiresRobot', () {
      final recipe = _scrambledEggsRecipe(requiresRobot: null);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.requiresRobot, recipe.requiresRobot);
    });

    test('not-null requiresRobot', () {
      final recipe = _scrambledEggsRecipe(requiresRobot: false);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.requiresRobot, recipe.requiresRobot);
    });

    test('precision', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(
        recipe2.ingredients.first.precision,
        recipe.ingredients.first.precision,
      );
    });

    test('mainComponent', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(
        recipe2.ingredients.first.mainComponent.description,
        recipe.ingredients.first.mainComponent.description,
      );
      expect(
        recipe2.category.mainComponent.description,
        recipe.category.mainComponent.description,
      );
    });

    test('null components', () {
      final recipe = _scrambledEggsRecipe(
        alternativeComponent: null,
        secondaryComponents: null,
        categoryAlternativeComponent: null,
        categorySecondaryComponents: null,
      );

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.ingredients.first.alternativeComponent, null);
      expect(recipe2.ingredients.first.secondaryComponents, null);
      expect(recipe2.category.alternativeComponent, null);
      expect(recipe2.category.secondaryComponents, null);
    });

    test('applianceType', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.mainApplianceType, recipe.mainApplianceType);
    });

    test('null secondaryApplianceType', () {
      final recipe = _scrambledEggsRecipe(secondaryApplianceType: null);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.secondaryApplianceType, null);
    });

    test('null secondaryApplianceType', () {
      final recipe =
          _scrambledEggsRecipe(secondaryApplianceType: ApplianceType.Cold);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.secondaryApplianceType, ApplianceType.Cold);
    });

    test('tags', () {
      final recipe = _scrambledEggsRecipe();

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.tags.length, recipe.tags.length);
      expect(recipe2.tags.last, recipe.tags.last);
    });

    test('null extraTags', () {
      final recipe = _scrambledEggsRecipe(extraTags: null);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.extraTags, null);
    });

    test('not null tags', () {
      final recipe = _scrambledEggsRecipe(extraTags: [
        'extraTag1',
        'extraTag2',
      ]);

      final map = recipe.toMap();
      final recipe2 = map.toRecipe();

      expect(recipe2.extraTags!.length, recipe2.extraTags!.length);
      expect(recipe2.extraTags!.last, recipe2.extraTags!.last);
    });
  });
}

Category _eggsCategory({
  Component? alternativeComponent,
  List<Component>? secondaryComponents,
}) =>
    Category(
      title: 'eggs',
      mainComponent: Component(
        description: 'category component',
      ),
      otherComponents: [
        Component(description: 'other category component 1'),
        Component(description: 'other category component 2'),
      ],
      alternativeComponent: alternativeComponent,
      secondaryComponents: secondaryComponents,
    );

Recipe _scrambledEggsRecipe({
  DateTime? expiryDate = null,
  Duration? totalDuration = null,
  bool? requiresRobot = null,
  Component? alternativeComponent,
  List<Component>? secondaryComponents,
  Component? categoryAlternativeComponent,
  List<Component>? categorySecondaryComponents,
  ApplianceType? secondaryApplianceType,
  List<String>? extraTags,
}) =>
    Recipe(
      category: _eggsCategory(
        alternativeComponent: categoryAlternativeComponent,
        secondaryComponents: categorySecondaryComponents,
      ),
      categoryKey: '5334',
      publishDate: DateTime(2021, 02, 05, 13, 15, 12),
      expiryDate: expiryDate,
      ingredients: [
        Ingredient(
          description: '',
          quantity: Decimal.fromInt(0),
          precision: 1202.067843212219876,
          cookingDuration: Duration(),
          mainComponent: Component(
            description: 'ingredient component',
          ),
          otherComponents: [
            Component(description: 'other ingredient component 1'),
            Component(description: 'other ingredient component 2'),
          ],
          alternativeComponent: alternativeComponent,
          secondaryComponents: secondaryComponents,
        ),
      ],
      title: 'Scrambled eggs',
      preparationDuration: Duration(minutes: 23, seconds: 30),
      totalDuration: totalDuration,
      isPublished: true,
      requiresRobot: requiresRobot,
      mainApplianceType: ApplianceType.Cutlery,
      secondaryApplianceType: secondaryApplianceType,
      tags: ['tag1', 'tag2'],
      extraTags: extraTags,
    );
