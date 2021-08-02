import 'expressions.dart';

/// Defines an expression that is equal
/// when the [left] is one of the values contained in the [right].
class In extends Expression {
  final Operand left;
  final ListInput right;

  const In(this.left, this.right);

  In.fieldList(String fieldPath, List<dynamic> values)
      : this(FieldPath(fieldPath), ListInput(values));
}
