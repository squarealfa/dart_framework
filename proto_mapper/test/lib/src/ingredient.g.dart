// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class IngredientProtoMapper implements ProtoMapper<Ingredient, GIngredient> {
  const IngredientProtoMapper();

  @override
  Ingredient fromProto(GIngredient proto) => _$IngredientFromProto(proto);

  @override
  GIngredient toProto(Ingredient entity) => _$IngredientToProto(entity);

  Ingredient fromJson(String json) =>
      _$IngredientFromProto(GIngredient.fromJson(json));
  String toJson(Ingredient entity) => _$IngredientToProto(entity).writeToJson();

  String toBase64Proto(Ingredient entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  Ingredient fromBase64Proto(String base64Proto) =>
      GIngredient.fromJson(utf8.decode(base64Decode(base64Proto)))
          .toIngredient();
}

GIngredient _$IngredientToProto(Ingredient instance) {
  var proto = GIngredient();

  proto.description = instance.description;
  proto.quantity = instance.quantity.toString();
  proto.precision = instance.precision;
  proto.cookingDuration = instance.cookingDuration.inMilliseconds.toDouble();
  proto.mainComponent =
      const ComponentProtoMapper().toProto(instance.mainComponent);
  proto.otherComponents.addAll(instance.otherComponents
      .map((e) => const ComponentProtoMapper().toProto(e)));

  if (instance.alternativeComponent != null) {
    proto.alternativeComponent =
        const ComponentProtoMapper().toProto(instance.alternativeComponent!);
  }
  proto.alternativeComponentHasValue = instance.alternativeComponent != null;

  proto.secondaryComponents.addAll(instance.secondaryComponents
          ?.map((e) => const ComponentProtoMapper().toProto(e)) ??
      []);
  proto.secondaryComponentsHasValue = instance.secondaryComponents != null;

  return proto;
}

Ingredient _$IngredientFromProto(GIngredient instance) => Ingredient(
      description: instance.description,
      quantity: Decimal.parse(instance.quantity),
      precision: instance.precision,
      cookingDuration: Duration(milliseconds: instance.cookingDuration.toInt()),
      mainComponent:
          const ComponentProtoMapper().fromProto(instance.mainComponent),
      otherComponents: instance.otherComponents
          .map((e) => const ComponentProtoMapper().fromProto(e))
          .toList(),
      alternativeComponent: (instance.alternativeComponentHasValue
          ? (const ComponentProtoMapper()
              .fromProto(instance.alternativeComponent))
          : null),
      secondaryComponents: (instance.secondaryComponentsHasValue
          ? (instance.secondaryComponents
              .map((e) => const ComponentProtoMapper().fromProto(e))
              .toList())
          : null),
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
