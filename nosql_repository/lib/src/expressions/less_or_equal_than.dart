import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] is lesser or equal to the [right].
class LessOrEqualThan extends BinaryExpression {
  const LessOrEqualThan(Operand left, Operand right) : super(left, right);
  LessOrEqualThan.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
