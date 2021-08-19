// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// BuilderGenerator
// **************************************************************************

class RecipeBuilder implements Builder<Recipe> {
  final _defaultsProvider = RecipeDefaultsProvider();

  String? $title;
  String get title => $title ?? _defaultsProvider.title;
  set title(String value) => $title = value;

  String? description;

  RecipeBuilder({
    String? title,
    this.description,
  }) {
    $title = title;
  }

  RecipeBuilder.fromRecipe(Recipe entity)
      : this(
          title: entity.title,
          description: entity.description,
        );

  @override
  Recipe build() {
    final entity = _build();
    const RecipeValidator().validateThrowing(entity);
    return entity;
  }

  @override
  BuildResult<Recipe> tryBuild() {
    try {
      final entity = _build();
      final errors = RecipeValidator().validate(entity);
      final result =
          BuildResult<Recipe>(result: entity, validationErrors: errors);
      return result;
    } catch (ex) {
      return BuildResult<Recipe>(exception: ex);
    }
  }

  Recipe _build() {
    var entity = Recipe(
      title: title,
      description: description,
    );
    return entity;
  }
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RecipeCopyWithExtension on Recipe {
  Recipe copyWith({
    String? title,
    String? description,
    bool setDescriptionToNull = false,
  }) {
    return Recipe(
      title: title ?? this.title,
      description:
          setDescriptionToNull ? null : description ?? this.description,
    );
  }
}

// **************************************************************************
// DefaultsProviderGenerator
// **************************************************************************

class RecipeDefaultsProvider {
  Recipe createWithDefaults({
    String? title,
  }) {
    return Recipe(
      title: title ?? this.title,
    );
  }

  String get title => '';
}

// **************************************************************************
// EntityAdapterGenerator
// **************************************************************************

class RecipePermissions extends EntityPermissions {
  const RecipePermissions();

  @override
  String get create => 'createRecipe';

  @override
  String get delete => 'deleteRecipe';

  @override
  String get read => 'readRecipe';

  @override
  String get update => 'updateRecipe';
}

class RecipeEntityAdapter implements EntityAdapter<Recipe> {
  @override
  final MapMapper<Recipe> mapMapper = const RecipeMapMapper();

  @override
  final Validator validator = const RecipeValidator();

  @override
  final EntityPermissions permissions = const RecipePermissions();
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class RecipeMapMapper extends MapMapper<Recipe> {
  const RecipeMapMapper();

  @override
  Recipe fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    var defaultsProvider = RecipeDefaultsProvider();

    return Recipe(
      title: getValueOrDefault(map['title'], () => defaultsProvider.title,
          (mapValue) => mapValue as String),
      description: map['description'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap(
    Recipe instance, [
    KeyHandler? keyHandler,
  ]) {
    final map = <String, dynamic>{};

    map['title'] = instance.title;
    map['description'] = instance.description;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().toMap(this, keyHandler);
  static Recipe fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(map, keyHandler);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(this, keyHandler);
}

class $RecipeFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $RecipeFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _title = 'title';
  String get title => prefix + _title;
  static const _description = 'description';
  String get description => prefix + _description;

  @override
  String toString() => fieldName;
}

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class RecipeProtoMapper implements ProtoMapper<Recipe, GRecipe> {
  const RecipeProtoMapper();

  @override
  Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);

  @override
  GRecipe toProto(Recipe entity) => _$RecipeToProto(entity);

  Recipe fromJson(String json) => _$RecipeFromProto(GRecipe.fromJson(json));
  String toJson(Recipe entity) => _$RecipeToProto(entity).writeToJson();

  String toBase64Proto(Recipe entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  Recipe fromBase64Proto(String base64Proto) =>
      GRecipe.fromJson(utf8.decode(base64Decode(base64Proto))).toRecipe();
}

GRecipe _$RecipeToProto(Recipe instance) {
  var proto = GRecipe();

  proto.title = instance.title;
  if (instance.description != null) {
    proto.description = instance.description!;
  }
  proto.descriptionHasValue = instance.description != null;

  return proto;
}

Recipe _$RecipeFromProto(GRecipe instance) => Recipe(
      title: instance.title,
      description:
          (instance.descriptionHasValue ? (instance.description) : null),
    );

extension RecipeProtoExtension on Recipe {
  GRecipe toProto() => _$RecipeToProto(this);
  String toJson() => _$RecipeToProto(this).writeToJson();

  static Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);
  static Recipe fromJson(String json) =>
      _$RecipeFromProto(GRecipe.fromJson(json));
}

extension GRecipeProtoExtension on GRecipe {
  Recipe toRecipe() => _$RecipeFromProto(this);
}

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class RecipeValidator implements Validator {
  const RecipeValidator();

  ValidationError? validateTitle(String value, {Recipe? entity}) {
    return null;
  }

  ValidationError? validateDescription(String? value, {Recipe? entity}) {
    return null;
  }

  ValidationError? $validateTitle(String? value, {Recipe? entity}) {
    if (value == null) {
      return RequiredValidationError('title');
    }
    return validateTitle(value, entity: entity);
  }

  @override
  ErrorList validate(covariant Recipe entity) {
    var errors = <ValidationError>[];

    ValidationError? error;
    if ((error = validateTitle(entity.title, entity: entity)) != null) {
      errors.add(error!);
    }

    if ((error = validateDescription(entity.description, entity: entity)) !=
        null) {
      errors.add(error!);
    }

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Recipe entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }
}
