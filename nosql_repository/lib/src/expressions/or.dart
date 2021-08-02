import 'expression.dart';

/// Represents an expression that is
/// true when [left] or [right] are true.
class Or extends Expression {
  final Expression left;
  final Expression right;

  const Or(this.left, this.right);
}
