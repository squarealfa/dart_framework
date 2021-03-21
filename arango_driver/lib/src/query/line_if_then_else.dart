import 'query_text_fragment.dart';

/// Line of query text with condition.
/// If [bool] `cond` is true, then [String] `when_true` will pasted into query.
/// Else [String] `when_false` willpasted into query.
/// Sample:
/// ```
/// Query([
///   Line('FOR doc in documents'),
///   LineIfThen(tag != null, 'FILTER doc.tags && POSITION( doc.tags, tag )'),
///   Line('SORT doc.datetime'),
///   LineIfThenElse(
///     without_content, 'return UNSET( doc, "content" )', 'return doc'),
///   ...
/// ])
/// ```
class LineIfThenElse extends QueryTextFragment {
  LineIfThenElse(bool cond, String whenTrue, String whenFalse) {
    line = cond ? whenTrue : whenFalse;
  }
}
