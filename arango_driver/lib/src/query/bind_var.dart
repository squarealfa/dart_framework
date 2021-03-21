import 'bind_name_value_pair.dart';

/// Simple pair of name-value to bind they to query as variable.
/// Sample:
/// ```
/// Query(
///      [
///         Line('LET tag=@tag'),
///         ... list of query lines
///            (see Line(), LineIfThen(), IfThemElse() for details )
///      ],
///      bindVars: [ BindVar( 'tag', tag ) ],
///    ).toMap()
/// ```
class BindVar extends BindNameValuePair {
  BindVar(String name, value) {
    bindNameValuePair = {name: value};
  }
}
