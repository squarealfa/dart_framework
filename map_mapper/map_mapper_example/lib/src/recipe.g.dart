// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class $RecipeMapMapper extends MapMapper<Recipe> {
  const $RecipeMapMapper();

  @override
  Recipe fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Recipe(
      key: $kh.keyFromMap(map, 'key'),
      title: map['ptitle'] as String,
      ingredients: List<Ingredient>.unmodifiable(map['ingredients']
          .map((e) => const $IngredientMapMapper().fromMap(e, $kh))),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Recipe instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.key, 'key');
    map['ptitle'] = instance.title;
    map['ingredients'] = instance.ingredients
        .map((e) => const $IngredientMapMapper().toMap(e, $kh))
        .toList();
    ;

    return map;
  }
}

extension $RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const $RecipeMapMapper().toMap(this, keyHandler);
  static Recipe fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      const $RecipeMapMapper().fromMap(map, keyHandler);
}

extension $MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe([KeyHandler? keyHandler]) =>
      const $RecipeMapMapper().fromMap(this, keyHandler);
}

class $RecipeFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $RecipeFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _key = 'key';
  String get key => prefix + keyHandler.fieldNameToMapKey(_key);
  static const _title = 'title';
  String get title => prefix + _title;
  static const _ingredients = 'ingredients';
  $IngredientFieldNames get ingredients => $IngredientFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _ingredients,
      );

  @override
  String toString() => fieldName;
}
