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
  Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'] as String,
      description: map['description'] as String?,
      category: CategoryMapMapper().fromMap(map['category']),
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((e) => IngredientMapMapper().fromMap(e))),
      publishDate: DateTime.parse(map['publishDate']),
      expiryDate:
          map['expiryDate'] == null ? null : DateTime.parse(map['expiryDate']),
      preparationDuration: Duration(milliseconds: map['preparationDuration']),
      totalDuration: map['totalDuration'] == null
          ? null
          : Duration(milliseconds: map['totalDuration']),
      isPublished: map['isPublished'] as bool,
      requiresRobot: map['requiresRobot'] as bool?,
      mainApplianceType:
          ApplianceTypeMapMapper().fromMap(map['mainApplianceType']),
      secondaryApplianceType: (map['secondaryApplianceType'] != null
          ? ApplianceTypeMapMapper().fromMap(map['secondaryApplianceType'])
          : null),
      tags: List<String>.from(map['tags']),
      extraTags:
          map['extraTags'] == null ? null : List<String>.from(map['extraTags']),
    );
  }

  @override
  Map<String, dynamic> toMap(Recipe instance) {
    final map = <String, dynamic>{};

    map['title'] = instance.title;
    map['description'] = instance.description;
    map['category'] = CategoryMapMapper().toMap(instance.category);
    map['ingredients'] = instance.ingredients
        .map((e) => IngredientMapMapper().toMap(e))
        .toList();
    ;
    map['publishDate'] = instance.publishDate.toIso8601String();
    map['expiryDate'] = instance.expiryDate?.toIso8601String();
    map['preparationDuration'] = instance.preparationDuration.inMilliseconds;
    map['totalDuration'] = instance.totalDuration?.inMilliseconds;
    map['isPublished'] = instance.isPublished;
    map['requiresRobot'] = instance.requiresRobot;
    map['mainApplianceType'] =
        ApplianceTypeMapMapper().toMap(instance.mainApplianceType);
    map['secondaryApplianceType'] = (instance.secondaryApplianceType == null
        ? null
        : ApplianceTypeMapMapper().toMap(instance.secondaryApplianceType!));
    map['tags'] = instance.tags;
    ;
    map['extraTags'] = instance.extraTags;
    ;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap() => RecipeMapMapper().toMap(this);
  static Recipe fromMap(Map<String, dynamic> map) =>
      RecipeMapMapper().fromMap(map);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe() => RecipeMapMapper().fromMap(this);
}
