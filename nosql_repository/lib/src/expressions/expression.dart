import 'expressions.dart';

/// Defines a business filtering expression
///
/// Filtering expressions can be composed and aggregated
/// to perform a more complex expression.
abstract class Expression {
  Expression();

  /// Creates an expression that filters a field for a value.
  factory Expression.equal(String fieldPath, dynamic value) {
    return Equal.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a set of possible values.
  factory Expression.inValues(String fieldPath, List<dynamic> values) {
    return In.fieldList(fieldPath, values);
  }

  /// Creates an expression that filters a field for a pattern match of a value.
  factory Expression.like(String fieldPath, dynamic value) {
    return Like.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a value different
  /// from the given [value].
  factory Expression.notEqual(String fieldPath, dynamic value) {
    return NotEqual.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a value that
  /// is greater than
  /// the given [value].
  factory Expression.greaterThan(String fieldPath, dynamic value) {
    return GreaterThan.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a value that is greater
  /// or equal to the given [value].
  factory Expression.greaterOrEqualThan(String fieldPath, dynamic value) {
    return GreaterOrEqualThan.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a value that is less
  /// than the given [value].
  factory Expression.lessThan(String fieldPath, dynamic value) {
    return LessThan.fieldValue(fieldPath, value);
  }

  /// Creates an expression that filters a field for a value that is lesser
  /// or equal to the given [value].
  factory Expression.lessOrEqualThan(String fieldPath, dynamic value) {
    return LessOrEqualThan.fieldValue(fieldPath, value);
  }

  /// Creates an expression that is true when [left] and [right] are true.
  factory Expression.and(Expression left, Expression right) {
    return And(left, right);
  }

  /// Creates an expression that is true when [left] or [right] are true.
  factory Expression.or(Expression left, Expression right) {
    return Or(left, right);
  }

  /// Creates an expression that is the boolean opposite of [expression].
  factory Expression.not(Expression expression) {
    return Not(expression);
  }
}

extension ExpressionExtension on Expression {
  Expression or(Expression other) {
    return Expression.or(this, other);
  }
  Expression and(Expression other) {
    return Expression.and(this, other);
  }
}
