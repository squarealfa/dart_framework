// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// BuilderGenerator
// **************************************************************************

class PersonBuilder implements Builder<Person> {
  List<AssetBuilder> assets;
  String name;

  PersonBuilder({
    required this.assets,
    required this.name,
  });

  factory PersonBuilder.fromPerson(Person entity) {
    return PersonBuilder(
      assets: entity.assets.map((e) => AssetBuilder.fromAsset(e)).toList(),
      name: entity.name,
    );
  }

  @override
  Person build() {
    var entity = Person(
      assets: assets.map((e) => e.build()).toList(),
      name: name,
    );
    PersonValidator().validateThrowing(entity);
    return entity;
  }
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PersonCopyWithExtension on Person {
  Person copyWith({
    List<Asset>? assets,
    String? name,
  }) {
    return Person(
      assets: assets ?? this.assets,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// DefaultsProviderGenerator
// **************************************************************************

class PersonDefaultsProvider {
  Person createWithDefaults({
    List<Asset>? assets,
    String? name,
  }) {
    return Person(
      assets: assets ?? this.assets,
      name: name ?? this.name,
    );
  }

  List<Asset> get assets => [];
  String get name => '';
}

// **************************************************************************
// EntityAdapterGenerator
// **************************************************************************

class PersonPermissions extends EntityPermissions {
  static final PersonPermissions _singleton = PersonPermissions._();

  PersonPermissions._();

  factory PersonPermissions() => _singleton;

  @override
  String get create => 'createPerson';

  @override
  String get delete => 'deletePerson';

  @override
  String get read => 'readPerson';

  @override
  String get update => 'updatePerson';
}

class PersonEntityAdapter implements EntityAdapter<Person> {
  @override
  final MapMapper<Person> mapMapper = PersonMapMapper();

  @override
  final Validator validator = PersonValidator();

  @override
  final EntityPermissions permissions = PersonPermissions();
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class PersonMapMapper extends MapMapper<Person> {
  static final PersonMapMapper _singleton = PersonMapMapper._();

  PersonMapMapper._();
  factory PersonMapMapper() => _singleton;

  @override
  Person fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    var defaultsProvider = PersonDefaultsProvider();
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Person(
      assets: getValueOrDefault(
          map['assets'],
          () => defaultsProvider.assets,
          (mapValue) => List<Asset>.from(
              mapValue.map((e) => AssetMapMapper().fromMap(e, $kh)))),
      name: getValueOrDefault(map['name'], () => defaultsProvider.name,
          (mapValue) => mapValue as String),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Person instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    map['assets'] =
        instance.assets.map((e) => AssetMapMapper().toMap(e, $kh)).toList();
    ;
    map['name'] = instance.name;

    return map;
  }
}

extension PersonMapExtension on Person {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      PersonMapMapper().toMap(this, keyHandler);
  static Person fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      PersonMapMapper().fromMap(map, keyHandler);
}

extension MapPersonExtension on Map<String, dynamic> {
  Person toPerson([KeyHandler? keyHandler]) =>
      PersonMapMapper().fromMap(this, keyHandler);
}

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class PersonProtoMapper implements ProtoMapper<Person, GPerson> {
  static final PersonProtoMapper _singleton = PersonProtoMapper._();

  PersonProtoMapper._();
  factory PersonProtoMapper() => _singleton;

  @override
  Person fromProto(GPerson proto) => _$PersonFromProto(proto);

  @override
  GPerson toProto(Person entity) => _$PersonToProto(entity);

  Person fromJson(String json) => _$PersonFromProto(GPerson.fromJson(json));
  String toJson(Person entity) => _$PersonToProto(entity).writeToJson();
}

GPerson _$PersonToProto(Person instance) {
  var proto = GPerson();

  proto.assets
      .addAll(instance.assets.map((e) => AssetProtoMapper().toProto(e)));

  proto.name = instance.name;

  return proto;
}

Person _$PersonFromProto(GPerson instance) => Person(
      assets:
          instance.assets.map((e) => AssetProtoMapper().fromProto(e)).toList(),
      name: instance.name,
    );

extension PersonProtoExtension on Person {
  GPerson toProto() => _$PersonToProto(this);
  String toJson() => _$PersonToProto(this).writeToJson();

  static Person fromProto(GPerson proto) => _$PersonFromProto(proto);
  static Person fromJson(String json) =>
      _$PersonFromProto(GPerson.fromJson(json));
}

extension GPersonProtoExtension on GPerson {
  Person toPerson() => _$PersonFromProto(this);
}

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class PersonValidator implements Validator {
  PersonValidator.create();

  static final PersonValidator _singleton = PersonValidator.create();
  factory PersonValidator() => _singleton;

  ValidationError? validateAssets(List<Asset> value) {
    var errorLists = value
        .map((entity) {
          var errors = AssetValidator().validate(entity);
          var itemErrors = ListItemErrorList(value, entity, errors);
          return itemErrors;
        })
        .where((p) => p.errorList.validationErrors.isNotEmpty)
        .toList();

    if (errorLists.isNotEmpty) {
      return ListPropertyValidation('assets', errorLists);
    }

    return null;
  }

  ValidationError? validateName(String value) {
    return null;
  }

  @override
  ErrorList validate(covariant Person entity) {
    var errors = <ValidationError>[];

    ValidationError? error;
    if ((error = validateAssets(entity.assets)) != null) {
      errors.add(error!);
    }

    if ((error = validateName(entity.name)) != null) {
      errors.add(error!);
    }

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Person entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }
}
