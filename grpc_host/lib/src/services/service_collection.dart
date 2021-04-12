import 'package:grpc/grpc.dart';
import 'package:nosql_repository/nosql_repository.dart';

typedef CreateRepositoryFunction = Repository<TEntity> Function<TEntity>();

abstract class ServiceCollection {
  final CreateRepositoryFunction createRepository;

  ServiceCollection(this.createRepository);

  List<Service> get services;
}
