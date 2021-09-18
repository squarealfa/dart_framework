// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty.dart';

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

class $EmptyValidator implements Validator {
  const $EmptyValidator();

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
