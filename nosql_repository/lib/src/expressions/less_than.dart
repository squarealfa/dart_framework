import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] is less than the [right].
class LessThan extends BinaryExpression {
  LessThan(Operand left, Operand right) : super(left, right);
  LessThan.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
