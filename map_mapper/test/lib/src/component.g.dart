// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class $ComponentMapMapper extends MapMapper<Component> {
  const $ComponentMapMapper();

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

extension $ComponentMapExtension on Component {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const $ComponentMapMapper().toMap(this, keyHandler);
  static Component fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      const $ComponentMapMapper().fromMap(map, keyHandler);
}

extension $MapComponentExtension on Map<String, dynamic> {
  Component toComponent([KeyHandler? keyHandler]) =>
      const $ComponentMapMapper().fromMap(this, keyHandler);
}

class $ComponentFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $ComponentFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _description = 'description';
  String get description => prefix + _description;

  @override
  String toString() => fieldName;
}
