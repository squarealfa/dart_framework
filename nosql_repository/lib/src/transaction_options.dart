import 'package:nosql_repository/nosql_repository.dart';

class TransactionOptions {
  final List<Repository> readRepositories;
  final List<Repository> writeRepositories;
  final List<Repository> exclusiveRepositories;

  const TransactionOptions({
    this.readRepositories = const [],
    this.writeRepositories = const [],
    this.exclusiveRepositories = const [],
  });
}
