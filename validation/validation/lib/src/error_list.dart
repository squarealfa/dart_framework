import 'validation_error.dart';

/// Contains the results of a validation check
class ErrorList {
  /// List of validation errors resulting from the check
  final Iterable<ValidationError> validationErrors;

  /// Returns a value indicating whether [validationErrors] is not empty
  bool get hasErrors => validationErrors.isNotEmpty;

  const ErrorList(this.validationErrors);

  factory ErrorList.merge(
      ErrorList otherErrorList, List<ValidationError> errors) {
    var consolidatedErrors = [...otherErrorList.validationErrors, ...errors];

    return ErrorList(consolidatedErrors);
  }
}
