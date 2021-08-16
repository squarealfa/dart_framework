// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

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
