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
      key: map['key'] as String,
      title: map['ptitle'] as String,
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((e) => IngredientMapMapper().fromMap(e, $kh))),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Recipe instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.key);
    map['ptitle'] = instance.title;
    map['ingredients'] = instance.ingredients
        .map((e) => IngredientMapMapper().toMap(e, $kh))
        .toList();
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
