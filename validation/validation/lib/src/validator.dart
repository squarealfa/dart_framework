import 'error_list.dart';

/// Performs validation on an object
abstract class Validator {

  /// Validates [entity] and returns a list of errors
  /// 
  /// This method will return an empty list if no validation error is found
  ErrorList validate(Object entity);

  /// Validates [entity] and throws when there is a validation error
  void validateThrowing(Object entity);
}
