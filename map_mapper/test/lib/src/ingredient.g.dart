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
      quantity: Decimal.parse(map['quantity']),
      precision: map['precision'] as double,
      cookingDuration: Duration(milliseconds: map['cookingDuration']),
      mainComponent: ComponentMapMapper().fromMap(map['mainComponent']),
      otherComponents: List<Component>.from(
          map['otherComponents'].map((e) => ComponentMapMapper().fromMap(e))),
      alternativeComponent: (map['alternativeComponent'] != null
          ? ComponentMapMapper().fromMap(map['alternativeComponent'])
          : null),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.from(map['secondaryComponents']
              .map((e) => ComponentMapMapper().fromMap(e))),
    );
  }

  @override
  Map<String, dynamic> toMap(Ingredient instance) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;
    map['quantity'] = instance.quantity.toString();
    map['precision'] = instance.precision;
    map['cookingDuration'] = instance.cookingDuration.inMilliseconds;
    map['mainComponent'] = ComponentMapMapper().toMap(instance.mainComponent);
    map['otherComponents'] = instance.otherComponents
        .map((e) => ComponentMapMapper().toMap(e))
        .toList();
    ;
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : ComponentMapMapper().toMap(instance.alternativeComponent!));
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => ComponentMapMapper().toMap(e))
            .toList();
    ;

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
