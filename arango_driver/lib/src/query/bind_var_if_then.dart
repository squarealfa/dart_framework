import 'bind_name_value_pair.dart';

/// Pair of variable name-value to bind they into query with condition.
/// Sample:
/// ```
/// Query(
///      [
///         LineIfThen( tag != null, 'LET tag=@tag'),
///         // ... list of other query lines (see Line(), LineIfThen(), LineIfThenElse() for details )
///      ],
///      bindVars: [ BindVarIfThen( tag!=null, 'tag', tag ) ],
///    ).toMap()
/// ```
class BindVarIfThen extends BindNameValuePair {
  BindVarIfThen(bool condition, String nameIfTrue, valueIfTrue) {
    if (condition) {
      bindNameValuePair = {nameIfTrue: valueIfTrue};
    }
  }
}
