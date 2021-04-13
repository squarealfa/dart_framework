import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

abstract class ServiceCollection {
  final Container container;

  ServiceCollection(this.container);

  EntityServicesParameters<TEntity> createServicesParameters<TEntity>(
      EntityAdapter<TEntity> entityAdapter) {
    final repository = container.resolve<Repository<TEntity>>();
    final ret =
        EntityServicesParameters.fromEntityAdapter(repository, entityAdapter);
    return ret;
  }

  List<Service> get services;
}
