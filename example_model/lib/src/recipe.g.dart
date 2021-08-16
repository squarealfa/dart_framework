// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class RecipeMapMapper extends MapMapper<Recipe> {
  const RecipeMapMapper();

  @override
  Recipe fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Recipe(
      key: $kh.keyFromMap(map, 'key'),
      title: map['title'] as String,
      ingredients: List<Ingredient>.from(map['ingredients']
          .map((e) => const IngredientMapMapper().fromMap(e, $kh))),
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

    $kh.keyToMap(map, instance.key, 'key');
    map['title'] = instance.title;
    map['ingredients'] = instance.ingredients
        .map((e) => const IngredientMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['runtimeTag'] = instance.runtimeTag;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().toMap(this, keyHandler);
  static Recipe fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(map, keyHandler);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(this, keyHandler);
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

  static const _runtimeTag = 'runtimeTag';
  String get runtimeTag => prefix + _runtimeTag;

  @override
  String toString() => fieldName;
}

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class RecipeProtoMapper implements ProtoMapper<Recipe, GRecipe> {
  const RecipeProtoMapper();

  @override
  Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);

  @override
  GRecipe toProto(Recipe entity) => _$RecipeToProto(entity);

  Recipe fromJson(String json) => _$RecipeFromProto(GRecipe.fromJson(json));
  String toJson(Recipe entity) => _$RecipeToProto(entity).writeToJson();

  String toBase64Proto(Recipe entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  Recipe fromBase64Proto(String base64Proto) =>
      GRecipe.fromJson(utf8.decode(base64Decode(base64Proto))).toRecipe();
}

GRecipe _$RecipeToProto(Recipe instance) {
  var proto = GRecipe();

  proto.key = instance.key;
  proto.ptitle = instance.title;
  proto.ingredients.addAll(instance.ingredients
      .map((e) => const IngredientProtoMapper().toProto(e)));

  return proto;
}

Recipe _$RecipeFromProto(GRecipe instance) => Recipe(
      key: instance.key,
      title: instance.ptitle,
      ingredients: instance.ingredients
          .map((e) => const IngredientProtoMapper().fromProto(e))
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
