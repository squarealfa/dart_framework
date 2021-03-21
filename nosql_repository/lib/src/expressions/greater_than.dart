import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] is greater than the [right].
class GreaterThan extends BinaryExpression {
  GreaterThan(Operand left, Operand right) : super(left, right);
  GreaterThan.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
