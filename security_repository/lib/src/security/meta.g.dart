// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension MetaCopyWithExtension on Meta {
  Meta copyWith({
    String? tenantKey,
  }) {
    return Meta(
      tenantKey: tenantKey ?? this.tenantKey,
    );
  }
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class MetaMapMapper extends MapMapper<Meta> {
  static final MetaMapMapper _singleton = MetaMapMapper._();

  MetaMapMapper._();
  factory MetaMapMapper() => _singleton;

  @override
  Meta fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Meta(
      tenantKey: $kh.keyFromMap(map, 'tenantKey'),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Meta instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.tenantKey);

    return map;
  }
}

extension MetaMapExtension on Meta {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      MetaMapMapper().toMap(this, keyHandler);
  static Meta fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      MetaMapMapper().fromMap(map, keyHandler);
}

extension MapMetaExtension on Map<String, dynamic> {
  Meta toMeta([KeyHandler? keyHandler]) =>
      MetaMapMapper().fromMap(this, keyHandler);
}
