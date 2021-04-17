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
      title: map['title'] as String,
      ingredients: List<Ingredient>.from(
          map['ingredients'].map((e) => IngredientMapMapper().fromMap(e, $kh))),
      runtimeTag: map['runtimeTag'] as String?,
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
    map['title'] = instance.title;
    map['ingredients'] = instance.ingredients
        .map((e) => IngredientMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['runtimeTag'] = instance.runtimeTag;

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

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class RecipeProtoMapper implements ProtoMapper<Recipe, GRecipe> {
  static final RecipeProtoMapper _singleton = RecipeProtoMapper._();

  RecipeProtoMapper._();
  factory RecipeProtoMapper() => _singleton;

  @override
  Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);

  @override
  GRecipe toProto(Recipe entity) => _$RecipeToProto(entity);

  Recipe fromJson(String json) => _$RecipeFromProto(GRecipe.fromJson(json));
  String toJson(Recipe entity) => _$RecipeToProto(entity).writeToJson();
}

GRecipe _$RecipeToProto(Recipe instance) {
  var proto = GRecipe();

  proto.key = instance.key;
  proto.ptitle = instance.title;
  proto.ingredients.addAll(
      instance.ingredients.map((e) => IngredientProtoMapper().toProto(e)));

  return proto;
}

Recipe _$RecipeFromProto(GRecipe instance) => Recipe(
      key: instance.key,
      title: instance.ptitle,
      ingredients: instance.ingredients
          .map((e) => IngredientProtoMapper().fromProto(e))
          .toList(),
    );

extension RecipeProtoExtension on Recipe {
  GRecipe toProto() => _$RecipeToProto(this);
  String toJson() => _$RecipeToProto(this).writeToJson();

  static Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);
  static Recipe fromJson(String json) =>
      _$RecipeFromProto(GRecipe.fromJson(json));
}

extension GRecipeProtoExtension on GRecipe {
  Recipe toRecipe() => _$RecipeFromProto(this);
}
