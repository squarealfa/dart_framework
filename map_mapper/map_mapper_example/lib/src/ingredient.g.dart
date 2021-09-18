// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class $IngredientMapMapper extends MapMapper<Ingredient> {
  const $IngredientMapMapper();

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

extension $IngredientMapExtension on Ingredient {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const $IngredientMapMapper().toMap(this, keyHandler);
  static Ingredient fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      const $IngredientMapMapper().fromMap(map, keyHandler);
}

extension $MapIngredientExtension on Map<String, dynamic> {
  Ingredient toIngredient([KeyHandler? keyHandler]) =>
      const $IngredientMapMapper().fromMap(this, keyHandler);
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
