import 'validation_error.dart';

class ErrorList {
  final Iterable<ValidationError> validationErrors;

  bool get hasErrors => validationErrors.isNotEmpty;

  const ErrorList(this.validationErrors);

  factory ErrorList.merge(
      ErrorList otherErrorList, List<ValidationError> errors) {
    var consolidatedErrors = [...otherErrorList.validationErrors, ...errors];

    return ErrorList(consolidatedErrors);
  }
}
