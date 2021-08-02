import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is true
/// when the [left] is different of the [right].
class NotEqual extends BinaryExpression {
  const NotEqual(Operand left, Operand right) : super(left, right);
  NotEqual.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
