// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class RecipeValidator implements Validator {
  RecipeValidator.create();

  static final RecipeValidator _singleton = RecipeValidator.create();
  factory RecipeValidator() => _singleton;

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
