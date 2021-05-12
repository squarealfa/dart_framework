import 'package:arango_driver/src/transactions/transaction.dart';

import 'arango_db_client.dart';
import 'query.dart';
import 'query/bind_name_value_pair.dart';
import 'query/bind_var.dart';
import 'query/bind_var_if_then.dart';
import 'query/bind_var_if_then_else.dart';
import 'query/line.dart';
import 'query/line_if_then.dart';
import 'query/query_text_fragment.dart';

class QueryWithClient extends Query {
  // a reference to the object that created this reference.
  ArangoDBClient client;

  QueryWithClient(this.client, List<QueryTextFragment> fragments,
      {List<BindNameValuePair> bindVars = const []})
      : super.create(fragments, bindVars: bindVars);

  /// Adds one [QueryTextFragment] to inner store of
  /// query fragments in during step by step constructing Query.
  ///
  /// Sample:
  /// ```
  /// .addQueryTextFragment( Line( 'FOR u IN users RETURN u' ) )
  /// ```
  QueryWithClient addQueryTextFragment(QueryTextFragment fragment) {
    fragments.add(fragment);
    return this;
  }

  /// Adds one [Line] to inner store of query fragments.
  ///
  /// Sample:
  /// ```
  /// .addLine( 'FOR u IN users RETURN u' )
  /// ```
  QueryWithClient addLine(String line) => addQueryTextFragment(Line(line));

  /// Adds one [LineIfThen] to inner store of query fragments.
  ///
  /// Sample:
  /// ```
  /// .addLineIfThen( user_name!=null, 'FILTER u.name==@user_name' )
  /// ```
  QueryWithClient addLineIfThen(bool cond, String line) =>
      addQueryTextFragment(LineIfThen(cond, line));

  /// Adds one pair of name-value binded to query
  /// Sample:
  /// ```
  /// .addBindNameValuePair( BindVar( 'user_name', 'Dmitriy' ) )
  /// ```
  QueryWithClient addBindNameValuePair(BindNameValuePair nameValuePair) {
    bindVars.add(nameValuePair);
    return this;
  }

  /// Adds one pair of name-value binded to query
  /// Sample:
  /// ```
  /// .addBindVar( 'user_name', 'Dmitry' )
  /// ```
  QueryWithClient addBindVar(String name, value) =>
      addBindNameValuePair(BindVar(name, value));

  /// Adds one condition-depended pair of name-value binded to query
  /// Sample:
  /// ```
  /// .addBindVarIfThen( user_name!=null, 'user_name', user_name )
  /// ```
  QueryWithClient addBindVarIfThen(bool cond, String name, value) =>
      addBindNameValuePair(BindVarIfThen(cond, name, value));

  /// Adds one condition-depended pair of name-value binded to query
  /// Sample:
  /// ```
  /// .addBindVarIfThenElse(
  ///   user_name!=null, 'user_name', user_name, 'max_user_age', 30 )
  /// ```
  QueryWithClient addBindVarIfThenElse(bool cond, String nameIfTrue,
          valueIfTrue, nameIfFalse, valuesIfFalse) =>
      addBindNameValuePair(BindVarIfThenElse(
          cond, nameIfTrue, valueIfTrue, nameIfFalse, valuesIfFalse));

  /// Calls `client.queryToList( this.toMap() )`
  /// where `client` is [ArangoDBClient] saved in `client` property.
  Future<List<Map<String, dynamic>>> runAndReturnFutureList(
          {Transaction? transaction}) async =>
      await client.queryToList(toMap(), transaction: transaction);

  /// Calls `client.queryToStream( this.toMap() )`
  /// where `client` is [ArangoDBClient] saved in `client` property.
  Stream<Map<String, dynamic>> runAndReturnStream({Transaction? transaction}) =>
      client.queryToStream(toMap(), transaction: transaction);
}
