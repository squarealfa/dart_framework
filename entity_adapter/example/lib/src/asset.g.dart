// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// BuilderGenerator
// **************************************************************************

class AssetBuilder implements Builder<Asset> {
  String description;
  Decimal value;

  AssetBuilder({
    required this.description,
    required this.value,
  });

  factory AssetBuilder.fromAsset(Asset entity) {
    return AssetBuilder(
      description: entity.description,
      value: entity.value,
    );
  }

  @override
  Asset build() {
    var entity = Asset(
      description: description,
      value: value,
    );
    AssetValidator().validateThrowing(entity);
    return entity;
  }
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AssetCopyWithExtension on Asset {
  Asset copyWith({
    String? description,
    Decimal? value,
  }) {
    return Asset(
      description: description ?? this.description,
      value: value ?? this.value,
    );
  }
}

// **************************************************************************
// DefaultsProviderGenerator
// **************************************************************************

class AssetDefaultsProvider {
  Asset createWithDefaults({
    String? description,
    Decimal? value,
  }) {
    return Asset(
      description: description ?? this.description,
      value: value ?? this.value,
    );
  }

  String get description => '';
  Decimal get value => Decimal.zero;
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class AssetMapMapper extends MapMapper<Asset> {
  static final AssetMapMapper _singleton = AssetMapMapper._();

  AssetMapMapper._();
  factory AssetMapMapper() => _singleton;

  @override
  Asset fromMap(Map<String, dynamic> map) {
    var defaultsProvider = AssetDefaultsProvider();

    return Asset(
      description: getValueOrDefault(map['description'],
          () => defaultsProvider.description, (mapValue) => mapValue as String),
      value: getValueOrDefault(map['value'], () => defaultsProvider.value,
          (mapValue) => Decimal.parse(mapValue)),
    );
  }

  @override
  Map<String, dynamic> toMap(Asset instance) {
    final map = <String, dynamic>{};

    map['description'] = instance.description;
    map['value'] = instance.value.toString();

    return map;
  }
}

extension AssetMapExtension on Asset {
  Map<String, dynamic> toMap() => AssetMapMapper().toMap(this);
  static Asset fromMap(Map<String, dynamic> map) =>
      AssetMapMapper().fromMap(map);
}

extension MapAssetExtension on Map<String, dynamic> {
  Asset toAsset() => AssetMapMapper().fromMap(this);
}

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class AssetProtoMapper implements ProtoMapper<Asset, GAsset> {
  static final AssetProtoMapper _singleton = AssetProtoMapper._();

  AssetProtoMapper._();
  factory AssetProtoMapper() => _singleton;

  @override
  Asset fromProto(GAsset proto) => _$AssetFromProto(proto);

  @override
  GAsset toProto(Asset entity) => _$AssetToProto(entity);

  Asset fromJson(String json) => _$AssetFromProto(GAsset.fromJson(json));
  String toJson(Asset entity) => _$AssetToProto(entity).writeToJson();
}

GAsset _$AssetToProto(Asset instance) {
  var proto = GAsset();

  proto.description = instance.description;
  proto.value = instance.value.toString();

  return proto;
}

Asset _$AssetFromProto(GAsset instance) => Asset(
      description: instance.description,
      value: Decimal.parse(instance.value),
    );

extension AssetProtoExtension on Asset {
  GAsset toProto() => _$AssetToProto(this);
  String toJson() => _$AssetToProto(this).writeToJson();

  static Asset fromProto(GAsset proto) => _$AssetFromProto(proto);
  static Asset fromJson(String json) => _$AssetFromProto(GAsset.fromJson(json));
}

extension GAssetProtoExtension on GAsset {
  Asset toAsset() => _$AssetFromProto(this);
}

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class AssetValidator implements Validator {
  AssetValidator.create();

  static final AssetValidator _singleton = AssetValidator.create();
  factory AssetValidator() => _singleton;

  ValidationError? validateDescription(String value) {
    return null;
  }

  ValidationError? validateValue(Decimal value) {
    return null;
  }

  @override
  ErrorList validate(covariant Asset entity) {
    var errors = <ValidationError>[];
    ValidationError? error;
    if ((error = validateDescription(entity.description)) != null) {
      errors.add(error!);
    }

    if ((error = validateValue(entity.value)) != null) {
      errors.add(error!);
    }

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Asset entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }
}
