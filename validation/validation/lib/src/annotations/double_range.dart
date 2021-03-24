/// Annotation that indicates the field to which it is applied to has
/// a range of values between min and max
class DoubleRange {
  final double? minValue;
  final double? maxValue;
  const DoubleRange({
    this.minValue,
    this.maxValue,
  });
}
