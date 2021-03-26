import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class RequiredValidationError extends ValidationError {
  const RequiredValidationError(String fieldName) : super(fieldName);
}
