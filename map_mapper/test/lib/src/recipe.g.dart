// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class RecipeMapMapper extends MapMapper<Recipe> {
  static final RecipeMapMapper _singleton = RecipeMapMapper._();

  RecipeMapMapper._();
  factory RecipeMapMapper() => _singleton;

  @override
  Recipe fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Recipe(
      title: map['title'] as String,
      description: map['description'] as String?,
      categoryKey: $kh.keyFromMap(map, 'categoryKey'),
      secondaryCategoryKey: map['secondaryCategoryKey'] == null
          ? null
          : $kh.keyFromMap(map, 'secondaryCategoryKey'),
      category: CategoryMapMapper().fromMap(map['category'], $kh),
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((e) => IngredientMapMapper().fromMap(e, $kh))),
      publishDate: DateTime.parse(map['publishDate']),
      expiryDate:
          map['expiryDate'] == null ? null : DateTime.parse(map['expiryDate']),
      preparationDuration: Duration(milliseconds: map['preparationDuration']),
      totalDuration: map['totalDuration'] == null
          ? null
          : Duration(milliseconds: map['totalDuration']),
      isPublished: map['isPublished'] as bool,
      requiresRobot: map['requiresRobot'] as bool?,
      mainApplianceType: ApplianceType.values[map['mainApplianceType'] as int],
      secondaryApplianceType: map['secondaryApplianceType'] == null
          ? null
          : ApplianceType.values[map['secondaryApplianceType'] as int],
      tags: List<String>.from(map['tags']),
      extraTags:
          map['extraTags'] == null ? null : List<String>.from(map['extraTags']),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Recipe instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    map['title'] = instance.title;
    map['description'] = instance.description;
    $kh.keyToMap(map, instance.categoryKey);
    $kh.keyToMap(map, instance.secondaryCategoryKey ?? '');
    map['category'] = CategoryMapMapper().toMap(instance.category, $kh);
    map['ingredients'] = instance.ingredients
        .map((e) => IngredientMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['publishDate'] = instance.publishDate.toIso8601String();
    map['expiryDate'] = instance.expiryDate?.toIso8601String();
    map['preparationDuration'] = instance.preparationDuration.inMilliseconds;
    map['totalDuration'] = instance.totalDuration?.inMilliseconds;
    map['isPublished'] = instance.isPublished;
    map['requiresRobot'] = instance.requiresRobot;
    map['mainApplianceType'] = instance.mainApplianceType.index;
    map['secondaryApplianceType'] = instance.secondaryApplianceType?.index;
    map['tags'] = instance.tags;
    ;
    map['extraTags'] = instance.extraTags;
    ;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      RecipeMapMapper().toMap(this, keyHandler);
  static Recipe fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      RecipeMapMapper().fromMap(map, keyHandler);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe([KeyHandler? keyHandler]) =>
      RecipeMapMapper().fromMap(this, keyHandler);
}
