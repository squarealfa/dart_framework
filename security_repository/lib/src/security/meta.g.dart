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
  Meta fromMap(Map<String, dynamic> map) {
    return Meta(
      tenantKey: map['tenantKey'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap(Meta instance) {
    final map = <String, dynamic>{};

    map['tenantKey'] = instance.tenantKey;

    return map;
  }
}

extension MetaMapExtension on Meta {
  Map<String, dynamic> toMap() => MetaMapMapper().toMap(this);
  static Meta fromMap(Map<String, dynamic> map) => MetaMapMapper().fromMap(map);
}

extension MapMetaExtension on Map<String, dynamic> {
  Meta toMeta() => MetaMapMapper().fromMap(this);
}
