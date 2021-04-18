import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'meta.g.dart';

@mapMap
@copyWith
class Meta {
  const Meta({
    required this.tenantKey,
  });

  final String tenantKey;
}
