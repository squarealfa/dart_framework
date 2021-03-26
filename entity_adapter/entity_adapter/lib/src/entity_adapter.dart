

import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import 'entity_permissions.dart';

abstract class EntityAdapter<TEntity, TProto> {
  MapMapper<TEntity> get mapMapper;
  ProtoMapper<TEntity, TProto> get protoMapper;
  Validator get validator;
  EntityPermissions get permissions;
}
