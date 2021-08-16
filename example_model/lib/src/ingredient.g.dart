// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class IngredientMapMapper extends MapMapper<Ingredient> {
  const IngredientMapMapper();

  @override
  Ingredient fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    return Ingredient(
      description: map['description'] as String,
      quantity: map['quantity'] as double,
    );
  }

  @override
  Map<String, dynamic> toMap(
    Ingredient instance, [
    KeyHandler? keyHandler,
  ]) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;
    map['quantity'] = instance.quantity;

    return map;
  }
}

extension IngredientMapExtension on Ingredient {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const IngredientMapMapper().toMap(this, keyHandler);
  static Ingredient fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      const IngredientMapMapper().fromMap(map, keyHandler);
}

extension MapIngredientExtension on Map<String, dynamic> {
  Ingredient toIngredient([KeyHandler? keyHandler]) =>
      const IngredientMapMapper().fromMap(this, keyHandler);
}

class $IngredientFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $IngredientFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _description = 'description';
  String get description => prefix + _description;
  static const _quantity = 'quantity';
  String get quantity => prefix + _quantity;

  @override
  String toString() => fieldName;
}

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
