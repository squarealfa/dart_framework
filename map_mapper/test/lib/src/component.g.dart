// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class ComponentMapMapper extends MapMapper<Component> {
  static final ComponentMapMapper _singleton = ComponentMapMapper._();

  ComponentMapMapper._();
  factory ComponentMapMapper() => _singleton;

  @override
  Component fromMap(Map<String, dynamic> map) {
    return Component(
      description: map['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap(Component instance) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;

    return map;
  }
}

extension ComponentMapExtension on Component {
  Map<String, dynamic> toMap() => ComponentMapMapper().toMap(this);
  static Component fromMap(Map<String, dynamic> map) =>
      ComponentMapMapper().fromMap(map);
}

extension MapComponentExtension on Map<String, dynamic> {
  Component toComponent() => ComponentMapMapper().fromMap(this);
}
