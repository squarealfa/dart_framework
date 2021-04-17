// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class IngredientMapMapper extends MapMapper<Ingredient> {
  static final IngredientMapMapper _singleton = IngredientMapMapper._();

  IngredientMapMapper._();
  factory IngredientMapMapper() => _singleton;

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
      IngredientMapMapper().toMap(this, keyHandler);
  static Ingredient fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      IngredientMapMapper().fromMap(map, keyHandler);
}

extension MapIngredientExtension on Map<String, dynamic> {
  Ingredient toIngredient([KeyHandler? keyHandler]) =>
      IngredientMapMapper().fromMap(this, keyHandler);
}
