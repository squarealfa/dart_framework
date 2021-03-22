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
      key: map['key'] as String,
      title: map['ptitle'] as String,
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((e) => IngredientMapMapper().fromMap(e))),
    );
  }

  @override
  Map<String, dynamic> toMap(Recipe instance) {
    final map = <String, dynamic>{};

    map['key'] = instance.key;
    map['ptitle'] = instance.title;
    map['ingredients'] = instance.ingredients
        .map((e) => IngredientMapMapper().toMap(e))
        .toList();
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
