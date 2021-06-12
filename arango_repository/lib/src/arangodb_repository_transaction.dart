import 'package:arango_driver/arango_driver.dart';
import 'package:nosql_repository/nosql_repository.dart';

class ArangoDbRepositoryTransaction extends RepositoryTransaction {
  final Transaction transaction;

  ArangoDbRepositoryTransaction(this.transaction);
}
