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
  Component fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    return Component(
      description: map['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap(
    Component instance, [
    KeyHandler? keyHandler,
  ]) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;

    return map;
  }
}

extension ComponentMapExtension on Component {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      ComponentMapMapper().toMap(this, keyHandler);
  static Component fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      ComponentMapMapper().fromMap(map, keyHandler);
}

extension MapComponentExtension on Map<String, dynamic> {
  Component toComponent([KeyHandler? keyHandler]) =>
      ComponentMapMapper().fromMap(this, keyHandler);
}
