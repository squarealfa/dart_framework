import 'bind_name_value_pair.dart';

/// Pair of variable name-value to bind they to query with condition.
/// Sample:
/// ```
/// Query(
///      [
///         LineIfThenElse(
///           tag != null, 'LET tag=@tag', 'LET other_name=@other_name'),
///         // ... list of query lines (see Line(), LineIfThen(), IfThemElse() for details )
///      ],
///      bindVars: [ BindVarIfThenElse(
///         tag!=null, 'tag', tag, 'other_name', other_value  ) ],
///    ).toMap()
/// ```
class BindVarIfThenElse extends BindNameValuePair {
  BindVarIfThenElse(bool condition, String nameIfTrue, valueIfTrue,
      String nameIfFalse, valueIfFalse) {
    if (condition) {
      bindNameValuePair = {nameIfTrue: valueIfTrue};
    } else {
      bindNameValuePair = {nameIfFalse: valueIfFalse};
    }
  }
}
