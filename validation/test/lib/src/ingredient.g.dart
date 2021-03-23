// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class IngredientValidator implements Validator {
  IngredientValidator.create();

  static final IngredientValidator _singleton = IngredientValidator.create();
  factory IngredientValidator() => _singleton;

  ValidationError? validateDescription(String value) {
    return null;
  }

  ValidationError? validateNotes(String? value) {
    return null;
  }

  ValidationError? validateTag(String? value) {
    return null;
  }

  ValidationError? validateQuantity(double value) {
    return null;
  }

  ValidationError? validatePrecision(Decimal value) {
    return null;
  }

  ValidationError? validateIntQuantity(int value) {
    return null;
  }

  ValidationError? validateNintQuantity(int? value) {
    return null;
  }

  ValidationError? validateRInt(int? value) {
    if (value == null) return RequiredValidationError('rInt');

    return null;
  }

  @override
  ErrorList validate(covariant Ingredient entity) {
    var errors = <ValidationError>[];
    ValidationError? error;
    if ((error = validateDescription(entity.description)) != null) {
      errors.add(error!);
    }

    if ((error = validateNotes(entity.notes)) != null) {
      errors.add(error!);
    }

    if ((error = validateTag(entity.tag)) != null) {
      errors.add(error!);
    }

    if ((error = validateQuantity(entity.quantity)) != null) {
      errors.add(error!);
    }

    if ((error = validatePrecision(entity.precision)) != null) {
      errors.add(error!);
    }

    if ((error = validateIntQuantity(entity.intQuantity)) != null) {
      errors.add(error!);
    }

    if ((error = validateNintQuantity(entity.nintQuantity)) != null) {
      errors.add(error!);
    }

    if ((error = validateRInt(entity.rInt)) != null) {
      errors.add(error!);
    }

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Ingredient entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }
}
