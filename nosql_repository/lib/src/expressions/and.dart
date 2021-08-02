import 'expression.dart';

/// Represents an expression that is
/// true when [left] and [right] are true.
class And extends Expression {
  final Expression left;
  final Expression right;

  const And(this.left, this.right);
}
