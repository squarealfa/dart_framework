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
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Ingredient(
      key: $kh.keyFromMap(map, 'key'),
      description: map['description'] as String,
      quantity: Decimal.parse(map['quantity']),
      precision: map['precision'] as double,
      cookingDuration: Duration(milliseconds: map['cookingDuration']),
      mainComponentKey: $kh.keyFromMap(map, 'mainComponentKey'),
      mainComponent: ComponentMapMapper().fromMap(map['mainComponent'], $kh),
      otherComponents: List<Component>.from(map['otherComponents']
          .map((e) => ComponentMapMapper().fromMap(e, $kh))),
      alternativeComponent: (map['alternativeComponent'] != null
          ? ComponentMapMapper().fromMap(map['alternativeComponent'], $kh)
          : null),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.from(map['secondaryComponents']
              .map((e) => ComponentMapMapper().fromMap(e, $kh))),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Ingredient instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.key, 'key');
    map['description'] = instance.description;
    map['quantity'] = instance.quantity.toString();
    map['precision'] = instance.precision;
    map['cookingDuration'] = instance.cookingDuration.inMilliseconds;
    $kh.keyToMap(map, instance.mainComponentKey, 'mainComponentKey');
    map['mainComponent'] =
        ComponentMapMapper().toMap(instance.mainComponent, $kh);
    map['otherComponents'] = instance.otherComponents
        .map((e) => ComponentMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : ComponentMapMapper().toMap(instance.alternativeComponent!, $kh));
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => ComponentMapMapper().toMap(e, $kh))
            .toList();
    ;

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
