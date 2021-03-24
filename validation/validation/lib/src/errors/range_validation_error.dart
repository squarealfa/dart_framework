import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class RangeValidationError extends ValidationError {
  const RangeValidationError(String fieldName) : super(fieldName);
}
