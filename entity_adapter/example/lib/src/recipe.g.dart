// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// BuilderGenerator
// **************************************************************************

class RecipeBuilder implements Builder<Recipe> {
  String title;
  String? description;

  RecipeBuilder({
    required this.title,
    this.description,
  });

  factory RecipeBuilder.fromRecipe(Recipe entity) {
    return RecipeBuilder(
      title: entity.title,
      description: entity.description,
    );
  }

  @override
  Recipe build() {
    var entity = Recipe(
      title: title,
      description: description,
    );
    RecipeValidator().validateThrowing(entity);
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
  static final RecipePermissions _singleton = RecipePermissions._();

  RecipePermissions._();

  factory RecipePermissions() => _singleton;

  @override
  String get create => 'createRecipe';

  @override
  String get delete => 'deleteRecipe';

  @override
  String get read => 'readRecipe';

  @override
  String get update => 'updateRecipe';
}

class RecipeEntityAdapter implements EntityAdapter<Recipe, GRecipe> {
  @override
  final MapMapper<Recipe> mapMapper = RecipeMapMapper();

  @override
  final ProtoMapper<Recipe, GRecipe> protoMapper = RecipeProtoMapper();

  @override
  final Validator validator = RecipeValidator();

  @override
  final EntityPermissions permissions = RecipePermissions();
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class RecipeMapMapper extends MapMapper<Recipe> {
  static final RecipeMapMapper _singleton = RecipeMapMapper._();

  RecipeMapMapper._();
  factory RecipeMapMapper() => _singleton;

  @override
  Recipe fromMap(Map<String, dynamic> map) {
    var defaultsProvider = RecipeDefaultsProvider();

    return Recipe(
      title: getValueOrDefault(map['title'], () => defaultsProvider.title,
          (mapValue) => mapValue as String),
      description: map['description'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap(Recipe instance) {
    final map = <String, dynamic>{};

    map['title'] = instance.title;
    map['description'] = instance.description;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap() => RecipeMapMapper().toMap(this);
  static Recipe fromMap(Map<String, dynamic> map) =>
      RecipeMapMapper().fromMap(map);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe() => RecipeMapMapper().fromMap(this);
}

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class RecipeProtoMapper implements ProtoMapper<Recipe, GRecipe> {
  static final RecipeProtoMapper _singleton = RecipeProtoMapper._();

  RecipeProtoMapper._();
  factory RecipeProtoMapper() => _singleton;

  @override
  Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);

  @override
  GRecipe toProto(Recipe entity) => _$RecipeToProto(entity);

  Recipe fromJson(String json) => _$RecipeFromProto(GRecipe.fromJson(json));
  String toJson(Recipe entity) => _$RecipeToProto(entity).writeToJson();
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
  RecipeValidator.create();

  static final RecipeValidator _singleton = RecipeValidator.create();
  factory RecipeValidator() => _singleton;

  ValidationError? validateTitle(String value) {
    return null;
  }

  ValidationError? validateDescription(String? value) {
    return null;
  }

  @override
  ErrorList validate(covariant Recipe entity) {
    var errors = <ValidationError>[];
    ValidationError? error;
    if ((error = validateTitle(entity.title)) != null) {
      errors.add(error!);
    }

    if ((error = validateDescription(entity.description)) != null) {
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
