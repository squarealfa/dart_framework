import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] is greater or equal to the [right].
class GreaterOrEqualThan extends BinaryExpression {
  const GreaterOrEqualThan(Operand left, Operand right) : super(left, right);
  GreaterOrEqualThan.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
