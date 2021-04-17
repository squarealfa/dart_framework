// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class CategoryMapMapper extends MapMapper<Category> {
  static final CategoryMapMapper _singleton = CategoryMapMapper._();

  CategoryMapMapper._();
  factory CategoryMapMapper() => _singleton;

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
      mainComponent: ComponentMapMapper().fromMap(map['mainComponent'], $kh),
      alternativeComponent: (map['alternativeComponent'] != null
          ? ComponentMapMapper().fromMap(map['alternativeComponent'], $kh)
          : null),
      otherComponents: List<Component>.from(map['otherComponents']
          .map((e) => ComponentMapMapper().fromMap(e, $kh))),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.from(map['secondaryComponents']
              .map((e) => ComponentMapMapper().fromMap(e, $kh))),
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
        ComponentMapMapper().toMap(instance.mainComponent, $kh);
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : ComponentMapMapper().toMap(instance.alternativeComponent!, $kh));
    map['otherComponents'] = instance.otherComponents
        .map((e) => ComponentMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => ComponentMapMapper().toMap(e, $kh))
            .toList();
    ;

    return map;
  }
}

extension CategoryMapExtension on Category {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      CategoryMapMapper().toMap(this, keyHandler);
  static Category fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      CategoryMapMapper().fromMap(map, keyHandler);
}

extension MapCategoryExtension on Map<String, dynamic> {
  Category toCategory([KeyHandler? keyHandler]) =>
      CategoryMapMapper().fromMap(this, keyHandler);
}
