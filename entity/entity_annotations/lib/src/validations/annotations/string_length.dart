/// Annotation that indicates the field to which it is applied to
/// has a length that ranges from [minLength] to [maxLength]
///
/// Nullable strings may be null and still pass a
/// minimum length validation. To validate that a
/// null string has a v
class StringLength {
  /// The minimum length of the string
  final int? minLength;

  /// The maximum length of the string
  final int? maxLength;

  const StringLength({
    this.minLength,
    this.maxLength,
  });
}
