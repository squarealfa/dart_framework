import 'expression.dart';
import 'operand.dart';

/// Represents an expression that is
/// composed of a [left] and a [right] part.
abstract class BinaryExpression extends Expression {
  final Operand left;
  final Operand right;

  BinaryExpression(this.left, this.right);
}
