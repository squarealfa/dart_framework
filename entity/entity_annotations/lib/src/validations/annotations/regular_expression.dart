/// Annotation that indicates the field to which it is applied to
/// has to math the given regular expression
class RegularExpression {
  /// The minimum length of the string
  final String expression;

  const RegularExpression({required this.expression});
}
