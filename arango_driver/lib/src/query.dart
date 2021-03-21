import 'query/bind_name_value_pair.dart';
import 'query/query_text_fragment.dart';

/// Constructor for constructing query as object from
/// understandable arguments with condition support.
/// Query object do not call database.
/// Query object can be converting to [Map] via toMap() method
/// and used as argument to `query()` method
/// of database client for sending.
/// For debug purpose query object can be printed as [String],
/// because it has toString() method.
/// Sample:
/// ```
/// var query = Query(
///      [
///        Line('LET tag=@tag'),
///        Line('FOR doc in docs'),
///        LineIfThen(
///           tag != null, 'FILTER doc.tags && POSITION(doc.tags, tag )'),
///        Line('SORT doc.datetime'),
///        LineIfThenElse(
///           without_content, 'return UNSET(doc,"content")', 'return doc'),
///      ],
///      bindVars: [BindVarIfThen(tag != null, 'tag', tag)],
///    ).toMap();
/// ```
class Query {
  // initial structures are set in constructors:
  List<QueryTextFragment> fragments = [];
  List<BindNameValuePair> bindVars = [];

  // The compiled result from all bindVars:
  Map<String, dynamic> bindVarsMap = {};

  /// Returns binded vars from query object.
  Map<String, dynamic> get bindedVars => bindVarsMap;

  Query(this.fragments, {List<BindNameValuePair> bindVars = const []}) {
    this.bindVars = bindVars;
  }

  /// Like Query() but named constructor.
  Query.create(fragments, {List<BindNameValuePair> bindVars = const []}) {
    Query(fragments, bindVars: bindVars);
  }

  /// Returns query string from [Query] object.
  String queryString() => fragments
      .map((f) => f.toString())
      .where((f) => f.isNotEmpty)
      .toList()
      .cast<String>()
      .join('\n');

  /// Returns created query object as [Map] structure,
  /// which contains keys: `'query'` and `'bindVars'`.
  /// The `'query'` key value contains
  /// a query text, `queryString()` method result.
  /// The `'bindVars'` key value contains
  /// a structure with binded variables, `bindedVars` getter result.
  Map<String, Object> toMap() {
    //let's collect bindVars into a Map:
    for (var bv in bindVars) {
      bindVarsMap.addAll(bv.bindNameValuePair);
    }

    var result = {
      'query': queryString(),
      'bindVars': bindedVars,
    };

    return result;
  }

  /// Human readable view of Query object.
  /// See `toMap()` method to get created query object as Map structure.
  @override
  String toString() => toMap().toString();
}
