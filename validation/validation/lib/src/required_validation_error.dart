import 'validation_error.dart';

class RequiredValidationError extends ValidationError {
  const RequiredValidationError(String fieldName) : super(fieldName);
}
