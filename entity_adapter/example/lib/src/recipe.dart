import 'package:example/grpc/recipe.pb.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

part 'recipe.g.dart';

const entity = EntityAdapted(rootEntityType: Entity);

class Entity {}

@entity
class Recipe extends Entity {
  final String title;
  final String? description;

  Recipe({
    required this.title,
    this.description,
  });
}
