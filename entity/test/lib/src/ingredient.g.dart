// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class $IngredientValidator implements Validator {
  const $IngredientValidator();

  ValidationError? validateDescription(String value, {Ingredient? entity}) {
    if (value.length < 10) {
      return StringLengthValidationError(
        'description',
        length: value.length,
        minLength: 10,
        maxLength: null,
      );
    }

    return null;
  }

  ValidationError? validateNotes(String? value, {Ingredient? entity}) {
    if (value != null && value.length > 10) {
      return StringLengthValidationError(
        'notes',
        length: value.length,
        minLength: null,
        maxLength: 10,
      );
    }

    return null;
  }

  ValidationError? validateTag(String? value, {Ingredient? entity}) {
    if (value != null && value.length < 2) {
      return StringLengthValidationError(
        'tag',
        length: value.length,
        minLength: 2,
        maxLength: null,
      );
    }

    return null;
  }

  ValidationError? validateQuantity(double value, {Ingredient? entity}) {
    if (value < 10.0) {
      return RangeValidationError('quantity',
          value: value, minValue: 10.0, maxValue: 20);
    }

    if (value > 20) {
      return RangeValidationError('quantity',
          value: value, minValue: 10.0, maxValue: 20);
    }

    return null;
  }

  ValidationError? validatePrecision(Decimal value, {Ingredient? entity}) {
    if (value < Decimal.fromInt(10)) {
      return RangeValidationError('precision',
          value: value, minValue: Decimal.fromInt(10), maxValue: null);
    }

    return null;
  }

  ValidationError? validateIntQuantity(int value, {Ingredient? entity}) {
    if (value < 10) {
      return RangeValidationError('intQuantity',
          value: value, minValue: 10, maxValue: 20);
    }

    if (value > 20) {
      return RangeValidationError('intQuantity',
          value: value, minValue: 10, maxValue: 20);
    }

    return null;
  }

  ValidationError? validateNintQuantity(int? value, {Ingredient? entity}) {
    if (value != null && value < 10) {
      return RangeValidationError('nintQuantity',
          value: value, minValue: 10, maxValue: 20);
    }

    if (value != null && value > 20) {
      return RangeValidationError('nintQuantity',
          value: value, minValue: 10, maxValue: 20);
    }

    return null;
  }

  ValidationError? validateRInt(int? value, {Ingredient? entity}) {
    if (value == null) {
      return RequiredValidationError('rInt');
    }

    if (value < 10) {
      return RangeValidationError('rInt',
          value: value, minValue: 10, maxValue: 20);
    }

    if (value > 20) {
      return RangeValidationError('rInt',
          value: value, minValue: 10, maxValue: 20);
    }

    return null;
  }

  ValidationError? $validateDescription(String? value, {Ingredient? entity}) {
    if (value == null) {
      return RequiredValidationError('description');
    }
    return validateDescription(value, entity: entity);
  }

  ValidationError? $validateQuantity(double? value, {Ingredient? entity}) {
    if (value == null) {
      return RequiredValidationError('quantity');
    }
    return validateQuantity(value, entity: entity);
  }

  ValidationError? $validatePrecision(Decimal? value, {Ingredient? entity}) {
    if (value == null) {
      return RequiredValidationError('precision');
    }
    return validatePrecision(value, entity: entity);
  }

  ValidationError? $validateIntQuantity(int? value, {Ingredient? entity}) {
    if (value == null) {
      return RequiredValidationError('intQuantity');
    }
    return validateIntQuantity(value, entity: entity);
  }

  @override
  ErrorList validate(covariant Ingredient entity) {
    var errors = <ValidationError>[];

    ValidationError? error;
    if ((error = validateDescription(entity.description, entity: entity)) !=
        null) {
      errors.add(error!);
    }

    if ((error = validateNotes(entity.notes, entity: entity)) != null) {
      errors.add(error!);
    }

    if ((error = validateTag(entity.tag, entity: entity)) != null) {
      errors.add(error!);
    }

    if ((error = validateQuantity(entity.quantity, entity: entity)) != null) {
      errors.add(error!);
    }

    if ((error = validatePrecision(entity.precision, entity: entity)) != null) {
      errors.add(error!);
    }

    if ((error = validateIntQuantity(entity.intQuantity, entity: entity)) !=
        null) {
      errors.add(error!);
    }

    if ((error = validateNintQuantity(entity.nintQuantity, entity: entity)) !=
        null) {
      errors.add(error!);
    }

    if ((error = validateRInt(entity.rInt, entity: entity)) != null) {
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
