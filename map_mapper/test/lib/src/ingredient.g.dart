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
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Ingredient(
      key: $kh.keyFromMap(map, 'key'),
      description: map['description'] as String,
      quantity: Decimal.parse(map['quantity']),
      precision: map['precision'] as double,
      cookingDuration: Duration(milliseconds: map['cookingDuration']),
      mainComponentKey: $kh.keyFromMap(map, 'mainComponentKey'),
      mainComponent:
          const ComponentMapMapper().fromMap(map['mainComponent'], $kh),
      otherComponents: List<Component>.from(map['otherComponents']
          .map((e) => const ComponentMapMapper().fromMap(e, $kh))),
      alternativeComponent: (map['alternativeComponent'] != null
          ? const ComponentMapMapper().fromMap(map['alternativeComponent'], $kh)
          : null),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.from(map['secondaryComponents']
              .map((e) => const ComponentMapMapper().fromMap(e, $kh))),
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
        const ComponentMapMapper().toMap(instance.mainComponent, $kh);
    map['otherComponents'] = instance.otherComponents
        .map((e) => const ComponentMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : const ComponentMapMapper()
            .toMap(instance.alternativeComponent!, $kh));
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => const ComponentMapMapper().toMap(e, $kh))
            .toList();
    ;

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

  static const _key = 'key';
  String get key => prefix + keyHandler.fieldNameToMapKey(_key);
  static const _description = 'description';
  String get description => prefix + _description;
  static const _quantity = 'quantity';
  String get quantity => prefix + _quantity;
  static const _precision = 'precision';
  String get precision => prefix + _precision;
  static const _cookingDuration = 'cookingDuration';
  String get cookingDuration => prefix + _cookingDuration;
  static const _mainComponentKey = 'mainComponentKey';
  String get mainComponentKey =>
      prefix + keyHandler.fieldNameToMapKey(_mainComponentKey);
  static const _mainComponent = 'mainComponent';
  $ComponentFieldNames get mainComponent => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _mainComponent,
      );
  static const _otherComponents = 'otherComponents';
  $ComponentFieldNames get otherComponents => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _otherComponents,
      );

  static const _alternativeComponent = 'alternativeComponent';
  $ComponentFieldNames get alternativeComponent => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _alternativeComponent,
      );
  static const _secondaryComponents = 'secondaryComponents';
  $ComponentFieldNames get secondaryComponents => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _secondaryComponents,
      );

  @override
  String toString() => fieldName;
}
