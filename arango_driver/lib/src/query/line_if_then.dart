import 'query_text_fragment.dart';

/// Line of query text with condition.
/// If [bool] `cond` is true, then [String] `when_true` will pasted into query.
/// Sample:
/// ```
/// Query([
///   Line('FOR doc in documents'),
///   LineIfThen(tag != null, 'FILTER doc.tags && POSITION( doc.tags, tag )'),
///   ...
/// ])
/// ```
class LineIfThen extends QueryTextFragment {
  LineIfThen(bool cond, String whenTrue) {
    line = cond ? whenTrue : '';
  }
}
