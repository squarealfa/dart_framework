import 'binary_expression.dart';
import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] fits the pattern defined by the [right].
class Like extends BinaryExpression {
  Like(Operand left, Operand right) : super(left, right);
  Like.fieldValue(String fieldPath, dynamic input)
      : this(FieldPath(fieldPath), Input(input));
}
