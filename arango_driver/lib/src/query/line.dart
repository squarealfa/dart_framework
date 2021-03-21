import 'query_text_fragment.dart';

/// Simple text line for injecting it into the query, constructed by [Query()].
/// Sample:
///  ```
/// Query([ Line('FOR doc in documents'), ... ])
/// ```
class Line extends QueryTextFragment {
  @override
  String line;

  Line(this.line);

  @override
  String toString() => line;
}
