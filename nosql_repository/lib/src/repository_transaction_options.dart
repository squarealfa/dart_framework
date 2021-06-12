import 'package:nosql_repository/nosql_repository.dart';

class RepositoryTransactionOptions {
  final List<Repository> readRepositories;
  final List<Repository> writeRepositories;
  final List<Repository> exclusiveRepositories;

  const RepositoryTransactionOptions({
    this.readRepositories = const [],
    this.writeRepositories = const [],
    this.exclusiveRepositories = const [],
  });
}
