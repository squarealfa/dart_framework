import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class StringLengthValidationError extends ValidationError {
  final int length;
  final int? minLength;
  final int? maxLength;

  const StringLengthValidationError(
    String fieldName, {
    required this.length,
    this.minLength,
    this.maxLength,
  }) : super(fieldName);
}
