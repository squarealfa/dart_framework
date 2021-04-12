import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

mixin CrudServiceMethods<TEntity extends Object> on EntityServices<TEntity> {
  Future<TEntity> create(TEntity entity) async {
    validator.validateThrowing(entity);
    var map = mapMapper.toMap(entity);
    map = await repository.create(
      map,
      call.principal,
    );

    entity = mapMapper.fromMap(map);
    return entity;
  }

  Future deleteByKeyValue(String keyValue) async {
    await repository.delete(
      keyValue,
      principal,
    );
  }

  Future<TEntity> getByKeyValue(String keyValue) async {
    var entity = await _get(principal, keyValue);
    return entity;
  }

  Future<TEntity> update(TEntity entity) async {
    validator.validateThrowing(entity);

    var map = mapMapper.toMap(entity);

    try {
      map = await repository.update(
        map,
        principal,
      );
    } on NotFound {
      throw GrpcError.notFound();
    } on Unauthorized {
      throwUnauthorized();
    }
    entity = mapMapper.fromMap(map);

    return entity;
  }

  Future<TEntity> _get(Principal principal, String key) async {
    var map = await repository.get(key, principal);
    var entity = mapMapper.fromMap(map);

    return entity;
  }
}
