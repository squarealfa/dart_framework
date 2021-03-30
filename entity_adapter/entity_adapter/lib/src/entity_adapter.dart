import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import 'entity_permissions.dart';

/// Acts as a facade to the features that are added
/// to PODOs
///
/// This creates, for each PODO class, a central
/// access point to the extra satellite features of
/// the PODO that are mainly code-generated and
/// are not central to the business concepts, but
/// artifacts that allow the PODO to be persisted,
/// transported via protocol buffer, validated
/// and require user permissions.
abstract class EntityAdapter<TEntity, TProto> {
  /// Gets an instance of a class that maps between the
  /// podo and Map<String, dynamic>
  MapMapper<TEntity> get mapMapper;

  /// Gets an instance of a class that maps between a PODO
  /// and its corresponding protocol buffer serializer and
  /// deserializer class
  ProtoMapper<TEntity, TProto> get protoMapper;

  /// Gets an instance of a validator of the PODO
  Validator get validator;

  /// Gets an instance of a class that contains the
  /// required permissions for each of the CRUD operations over the PODO
  EntityPermissions get permissions;
}
