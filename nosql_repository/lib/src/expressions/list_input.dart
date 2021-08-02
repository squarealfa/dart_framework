import 'expressions.dart';

/// Defines an operand that is a list of possible values.
class ListInput extends Operand {
  final List<dynamic> values;
  const ListInput(this.values);
}
