import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:grpc_host/src/services/authenticated_services.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

import 'entity_services_parameters.dart';

class EntityServices<TEntity> extends AuthenticatedServices {
  final Repository<TEntity> repository;

  final MapMapper<TEntity> mapMapper;
  final EntityPermissions permissions;
  final Validator validator;

  EntityServices(ServiceCall call, EntityServicesParameters<TEntity> parameters)
      : repository = parameters.repository,
        validator = parameters.validator,
        permissions = parameters.permissions,
        mapMapper = parameters.mapMapper,
        super(call);

  Future<Stream<Map<String, dynamic>>> findToStream([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    final result = await repository.searchToStream(criteria, principal);
    return result;
  }

  Future<Stream<TEntity>> findToEntityStream([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    final mapStream = await findToStream(criteria);
    final entityStream = mapStream.map((m) => mapMapper.fromMap(m));

    return entityStream;
  }

  Future<List<TEntity>> findToEntityList([
    SearchCriteria criteria = const SearchCriteria(),
  ]) async {
    final stream = await findToStream(criteria);
    final list = stream.map((m) => mapMapper.fromMap(m)).toList();
    return list;
  }

  Future<PagedSearchResult<TEntity>> findToEntityPage(
    SearchCriteria criteria, {
    TEntity Function(Map<String, dynamic> map)? mapper,
  }) async {
    final searchResult = await repository.searchWithCount(criteria, principal);
    mapper ??= mapMapper.fromMap;
    var page = await searchResult.page.map((m) => mapper!(m)).toList();

    final ret = PagedSearchResult(
      count: searchResult.count,
      page: page,
    );
    return ret;
  }

  Future<PagedSearchResult<TPageItem>> findPage<TPageItem>(
    SearchCriteria criteria, {
    required TPageItem Function(Map<String, dynamic> map) mapper,
  }) async {
    final searchResult = await repository.searchWithCount(criteria, principal);
    var page = await searchResult.page.map((m) {
      final entity = mapper(m);
      return entity;
    }).toList();

    final ret = PagedSearchResult(
      count: searchResult.count,
      page: page,
    );
    return ret;
  }
}
