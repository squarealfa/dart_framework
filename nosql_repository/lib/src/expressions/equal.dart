import 'binary_expression.dart';
import 'expressions.dart';

/// Represents an expression that is
/// true when the [left] operand is equal to the [right] operand.
class Equal extends BinaryExpression {
  const Equal(Operand left, Operand right) : super(left, right);

  Equal.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
