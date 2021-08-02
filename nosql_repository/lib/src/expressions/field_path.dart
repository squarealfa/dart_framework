import 'operand.dart';

/// Defines a path to search for a value
/// of a field within a document in a collection.
class FieldPath extends Operand {
  final String fieldPath;

  const FieldPath(this.fieldPath);
}
