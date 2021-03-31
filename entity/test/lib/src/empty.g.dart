// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class EmptyValidator implements Validator {
  EmptyValidator.create();

  static final EmptyValidator _singleton = EmptyValidator.create();
  factory EmptyValidator() => _singleton;

  @override
  ErrorList validate(covariant Empty entity) {
    var errors = <ValidationError>[];

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Empty entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }
}
