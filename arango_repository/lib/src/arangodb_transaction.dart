import 'package:arango_driver/arango_driver.dart';
import 'package:nosql_repository/nosql_repository.dart' as repo;

class ArangoDbTransaction extends repo.Transaction {
  final Transaction transaction;

  ArangoDbTransaction(this.transaction);
}
