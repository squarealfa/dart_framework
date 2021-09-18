// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class $CategoryMapMapper extends MapMapper<Category> {
  const $CategoryMapMapper();

  @override
  Category fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Category(
      id: $kh.keyFromMap(map, 'id'),
      title: map['title'] as String,
      mainComponentId: $kh.keyFromMap(map, 'mainComponentId'),
      mainComponent:
          const $ComponentMapMapper().fromMap(map['mainComponent'], $kh),
      alternativeComponent: (map['alternativeComponent'] != null
          ? const $ComponentMapMapper()
              .fromMap(map['alternativeComponent'], $kh)
          : null),
      otherComponents: List<Component>.unmodifiable(map['otherComponents']
          .map((e) => const $ComponentMapMapper().fromMap(e, $kh))),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.unmodifiable(map['secondaryComponents']
              .map((e) => const $ComponentMapMapper().fromMap(e, $kh))),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Category instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.id, 'id');
    map['title'] = instance.title;
    $kh.keyToMap(map, instance.mainComponentId, 'mainComponentId');
    map['mainComponent'] =
        const $ComponentMapMapper().toMap(instance.mainComponent, $kh);
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : const $ComponentMapMapper()
            .toMap(instance.alternativeComponent!, $kh));
    map['otherComponents'] = instance.otherComponents
        .map((e) => const $ComponentMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => const $ComponentMapMapper().toMap(e, $kh))
            .toList();
    ;

    return map;
  }
}

extension $CategoryMapExtension on Category {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const $CategoryMapMapper().toMap(this, keyHandler);
  static Category fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      const $CategoryMapMapper().fromMap(map, keyHandler);
}

extension $MapCategoryExtension on Map<String, dynamic> {
  Category toCategory([KeyHandler? keyHandler]) =>
      const $CategoryMapMapper().fromMap(this, keyHandler);
}

class $CategoryFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $CategoryFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _id = 'id';
  String get id => prefix + keyHandler.fieldNameToMapKey(_id);
  static const _title = 'title';
  String get title => prefix + _title;
  static const _mainComponentId = 'mainComponentId';
  String get mainComponentId =>
      prefix + keyHandler.fieldNameToMapKey(_mainComponentId);
  static const _mainComponent = 'mainComponent';
  $ComponentFieldNames get mainComponent => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _mainComponent,
      );
  static const _alternativeComponent = 'alternativeComponent';
  $ComponentFieldNames get alternativeComponent => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _alternativeComponent,
      );
  static const _otherComponents = 'otherComponents';
  $ComponentFieldNames get otherComponents => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _otherComponents,
      );

  static const _secondaryComponents = 'secondaryComponents';
  $ComponentFieldNames get secondaryComponents => $ComponentFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _secondaryComponents,
      );

  @override
  String toString() => fieldName;
}
