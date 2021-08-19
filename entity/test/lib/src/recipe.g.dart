// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// BuilderGenerator
// **************************************************************************

class RecipeBuilder implements Builder<Recipe> {
  String? $title;
  String get title => $title!;
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
// ValidatorGenerator
// **************************************************************************

class RecipeValidator implements Validator {
  const RecipeValidator();

  ValidationError? validateTitle(String value, {Recipe? entity}) {
    if (value.isEmpty) {
      return RequiredValidationError('title');
    }

    return null;
  }

  ValidationError? validateDescription(String? value, {Recipe? entity}) {
    if (value?.isEmpty ?? true) {
      return RequiredValidationError('description');
    }

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
