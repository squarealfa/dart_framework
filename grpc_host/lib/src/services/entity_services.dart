import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

import 'entity_services_parameters.dart';

class EntityServices<TEntity> {
  final ServiceCall call;
  final Principal principal;
  final Repository<TEntity> repository;

  final MapMapper<TEntity> mapMapper;
  final EntityPermissions permissions;
  final Validator validator;

  EntityServices(ServiceCall call, EntityServicesParameters<TEntity> parameters)
      : call = call,
        principal = call.principal,
        repository = parameters.repository,
        validator = parameters.validator,
        permissions = parameters.permissions,
        mapMapper = parameters.mapMapper {
    if (!principal.isAuthenticated) {
      throw GrpcError.unauthenticated();
    }
  }

  void throwOnError(ErrorList errors) {
    if (errors.hasErrors) throw errors;
  }

  void throwUnauthorized() {
    throw GrpcError.unauthenticated('Unauthorized');
  }

  void throwNotFound() {
    throw GrpcError.notFound();
  }

  Future<Stream<Map<String, dynamic>>> findToStream([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    var result = await repository.searchToStream(criteria, principal);
    return result;
  }

  Future<Stream<TEntity>> findToEntityStream([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    final mapStream = await findToStream(criteria);
    var entityStream = mapStream.map((m) => mapMapper.fromMap(m));

    return entityStream;
  }

  Future<List<TEntity>> findToEntityList([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    var stream = await findToStream(criteria);
    var list = stream.map((m) => mapMapper.fromMap(m)).toList();
    return list;
  }
}
