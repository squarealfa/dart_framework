//import 'package:model/model.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

class EntityServicesParameters<TEntity> {
  final Repository<TEntity> repository;

  final MapMapper<TEntity> mapMapper;
  final EntityPermissions permissions;
  final Validator validator;

  EntityServicesParameters({
    required this.repository,
    required this.mapMapper,
    required this.permissions,
    required this.validator,
  });

  factory EntityServicesParameters.fromEntityAdapter(
    Repository<TEntity> repository,
    EntityAdapter<TEntity> adapter,
  ) {
    final mapMapper = adapter.mapMapper;
    final permissions = adapter.permissions;
    final validator = adapter.validator;
    final ret = EntityServicesParameters(
      repository: repository,
      mapMapper: mapMapper,
      permissions: permissions,
      validator: validator,
    );
    return ret;
  }
}
