import 'package:example/grpc/person.pb.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

import 'asset.dart';
import 'entity.dart';

part 'person.g.dart';

@entity
class Person extends Entity {
  final List<Asset> assets;

  final String name;

  Person({
    required this.assets,
    required this.name,
  });
}
