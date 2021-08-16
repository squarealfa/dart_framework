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
// ValidatorGenerator
// **************************************************************************

class RecipeValidator implements Validator {
  const RecipeValidator();

  ValidationError? validateTitle(String value) {
    if (value.isEmpty) {
      return RequiredValidationError('title');
    }

    return null;
  }

  ValidationError? validateDescription(String? value) {
    if (value?.isEmpty ?? true) {
      return RequiredValidationError('description');
    }

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
