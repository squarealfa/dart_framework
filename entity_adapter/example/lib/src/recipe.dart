import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:example/grpc/recipe.pb.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'recipe.g.dart';

const entity = AdaptEntity(rootEntityType: Entity);

class Entity {}

@entity
@validatable
@builder
@copyWith
class Recipe extends Entity {
  final String title;
  final String? description;

  Recipe({
    required this.title,
    this.description,
  });
}
