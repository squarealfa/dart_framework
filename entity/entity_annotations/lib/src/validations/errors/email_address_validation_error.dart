import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class EmailAddressValidationError extends ValidationError {
  const EmailAddressValidationError(String fieldName) : super(fieldName);
}
