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
  Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      description: map['description'] as String,
      quantity: map['quantity'] as double,
    );
  }

  @override
  Map<String, dynamic> toMap(Ingredient instance) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;
    map['quantity'] = instance.quantity;

    return map;
  }
}

extension IngredientMapExtension on Ingredient {
  Map<String, dynamic> toMap() => IngredientMapMapper().toMap(this);
  static Ingredient fromMap(Map<String, dynamic> map) =>
      IngredientMapMapper().fromMap(map);
}

extension MapIngredientExtension on Map<String, dynamic> {
  Ingredient toIngredient() => IngredientMapMapper().fromMap(this);
}
