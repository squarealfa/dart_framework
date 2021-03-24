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
    if (value.length < 10) {
      return StringLengthValidationError('description');
    }

    return null;
  }

  ValidationError? validateNotes(String? value) {
    if (value != null && value.length > 10) {
      return StringLengthValidationError('notes');
    }

    return null;
  }

  ValidationError? validateTag(String? value) {
    if (value != null && value.length < 2) {
      return StringLengthValidationError('tag');
    }

    return null;
  }

  ValidationError? validateQuantity(double value) {
    if (value < 10.0) {
      return RangeValidationError('quantity');
    }

    if (value > 20.0) {
      return RangeValidationError('quantity');
    }

    return null;
  }

  ValidationError? validatePrecision(Decimal value) {
    if (value < Decimal.fromInt(10)) {
      return RangeValidationError('precision');
    }

    return null;
  }

  ValidationError? validateIntQuantity(int value) {
    if (value < 10) {
      return RangeValidationError('intQuantity');
    }

    if (value > 20) {
      return RangeValidationError('intQuantity');
    }

    return null;
  }

  ValidationError? validateNintQuantity(int? value) {
    if (value != null && value < 10) {
      return RangeValidationError('nintQuantity');
    }

    if (value != null && value > 20) {
      return RangeValidationError('nintQuantity');
    }

    return null;
  }

  ValidationError? validateRInt(int? value) {
    if (value == null) {
      return RequiredValidationError('rInt');
    }

    if (value < 10) {
      return RangeValidationError('rInt');
    }

    if (value > 20) {
      return RangeValidationError('rInt');
    }

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
