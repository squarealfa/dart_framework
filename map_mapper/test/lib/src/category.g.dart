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
  Category fromMap(Map<String, dynamic> map) {
    return Category(
      title: map['title'] as String,
      mainComponent: ComponentMapMapper().fromMap(map['mainComponent']),
      alternativeComponent: (map['alternativeComponent'] != null
          ? ComponentMapMapper().fromMap(map['alternativeComponent'])
          : null),
      otherComponents: List<Component>.from(
          map['otherComponents'].map((e) => ComponentMapMapper().fromMap(e))),
      secondaryComponents: map['secondaryComponents'] == null
          ? null
          : List<Component>.from(map['secondaryComponents']
              .map((e) => ComponentMapMapper().fromMap(e))),
    );
  }

  @override
  Map<String, dynamic> toMap(Category instance) {
    final map = <String, dynamic>{};

    map['title'] = instance.title;
    map['mainComponent'] = ComponentMapMapper().toMap(instance.mainComponent);
    map['alternativeComponent'] = (instance.alternativeComponent == null
        ? null
        : ComponentMapMapper().toMap(instance.alternativeComponent!));
    map['otherComponents'] = instance.otherComponents
        .map((e) => ComponentMapMapper().toMap(e))
        .toList();
    ;
    map['secondaryComponents'] = instance.secondaryComponents == null
        ? null
        : instance.secondaryComponents!
            .map((e) => ComponentMapMapper().toMap(e))
            .toList();
    ;

    return map;
  }
}

extension CategoryMapExtension on Category {
  Map<String, dynamic> toMap() => CategoryMapMapper().toMap(this);
  static Category fromMap(Map<String, dynamic> map) =>
      CategoryMapMapper().fromMap(map);
}

extension MapCategoryExtension on Map<String, dynamic> {
  Category toCategory() => CategoryMapMapper().fromMap(this);
}
