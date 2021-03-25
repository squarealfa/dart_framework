import 'package:map_mapper_annotations/map_mapper_annotations.dart';

import '../entity_adapter.dart';

abstract class EntityAdapter<TEntity, TProto> {
  MapMapper<TEntity> get mapMapper;
  ProtoMapper<TEntity, TProto> get protoMapper;
  Validator get validator;
  EntityPermissions get permissions;
}
