import 'expressions.dart';

/// Defines an operand that can be used in
/// an [Expression]
abstract class Operand {
  Operand();

  /// Creates an operand that represents a [FieldPath].
  factory Operand.field(String path) {
    return FieldPath(path);
  }

  /// Creates an operand that represents an [Input].
  factory Operand.input(dynamic input) {
    return Input(input);
  }

  /// Creates an operand that represents a [ListInput].
  factory Operand.list(List<dynamic> values) {
    return ListInput(values);
  }
}
