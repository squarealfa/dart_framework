import 'arango_db_client.dart';
import 'query_with_client.dart';

/// Adds the newQuery method to the ArangoDBClient class.
extension ArangoClientQuery on ArangoDBClient {
  /// Creates new [QueryWithClient] (with saved link to client) object
  /// for continue to constructing it later.
  QueryWithClient newQuery() {
    return QueryWithClient(this, []);
  }
}
