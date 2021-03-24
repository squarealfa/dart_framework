/// Represents a validation error
class ValidationError {
  /// The name of the field with the error
  final String propertyName;

  const ValidationError(this.propertyName);
}
