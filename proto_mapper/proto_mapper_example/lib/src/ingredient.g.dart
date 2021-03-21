// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class IngredientProtoMapper implements ProtoMapper<Ingredient, GIngredient> {
  static final IngredientProtoMapper _singleton = IngredientProtoMapper._();

  IngredientProtoMapper._();
  factory IngredientProtoMapper() => _singleton;

  @override
  Ingredient fromProto(GIngredient proto) => _$IngredientFromProto(proto);

  @override
  GIngredient toProto(Ingredient entity) => _$IngredientToProto(entity);

  Ingredient fromJson(String json) =>
      _$IngredientFromProto(GIngredient.fromJson(json));
  String toJson(Ingredient entity) => _$IngredientToProto(entity).writeToJson();
}

GIngredient _$IngredientToProto(Ingredient instance) {
  var proto = GIngredient();

  proto.description = instance.description;
  proto.quantity = instance.quantity;

  return proto;
}

Ingredient _$IngredientFromProto(GIngredient instance) => Ingredient(
      description: instance.description,
      quantity: instance.quantity,
    );

extension IngredientProtoExtension on Ingredient {
  GIngredient toProto() => _$IngredientToProto(this);
  String toJson() => _$IngredientToProto(this).writeToJson();

  static Ingredient fromProto(GIngredient proto) =>
      _$IngredientFromProto(proto);
  static Ingredient fromJson(String json) =>
      _$IngredientFromProto(GIngredient.fromJson(json));
}

extension GIngredientProtoExtension on GIngredient {
  Ingredient toIngredient() => _$IngredientFromProto(this);
}
