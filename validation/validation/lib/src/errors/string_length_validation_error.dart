import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class StringLengthValidationError extends ValidationError {
  const StringLengthValidationError(String fieldName) : super(fieldName);
}
