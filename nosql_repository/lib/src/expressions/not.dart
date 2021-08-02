import 'expression.dart';

/// Defines an expression that is the boolean
/// opposite of the [expression].
class Not extends Expression {
  final Expression expression;

  const Not(this.expression);
}
