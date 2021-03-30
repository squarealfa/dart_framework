import 'package:decimal/decimal.dart';
import 'package:example/grpc/asset.pb.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

import 'entity.dart';

part 'asset.g.dart';

@entity
class Asset {
  final String description;
  final Decimal value;

  Asset({
    required this.description,
    required this.value,
  });
}
