import 'validation_error.dart';

/// Represents an error indicating that a required value is missing
class RangeValidationError<T> extends ValidationError {
  final T value;
  final T? minValue;
  final T? maxValue;
  const RangeValidationError(
    String fieldName, {
    required this.value,
    this.minValue,
    this.maxValue,
  }) : super(fieldName);
}
