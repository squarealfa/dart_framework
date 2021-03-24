import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';

import 'grpc/ingredient.pb.dart';

part 'ingredient.g.dart';

@mapEntity
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}

class MapEntity implements Proto, MapProto, MapMap {
  @override
  final String packageName;
  @override
  final String? prefix;
  @override
  final bool useDefaultsProvider;

  @override
  final bool includeFieldsByDefault;

  const MapEntity({
    this.prefix = 'G',
    this.packageName = '',
    this.useDefaultsProvider = false,
    this.includeFieldsByDefault = true,
  });
}

const mapEntity = MapEntity();
