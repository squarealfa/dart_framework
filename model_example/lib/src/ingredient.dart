import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_annotations/src/annotations/proto.dart';
import 'grpc/ingredient.pb.dart';

part 'ingredient.g.dart';

@X()
// @mapMap
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}

class X implements Proto, MapProto, MapMap {
  @override
  final String packageName;
  @override
  final String? prefix;
  @override
  final bool includeFieldsByDefault;
  @override
  final bool nullableFieldsByDefault;
  @override
  final bool useDefaultsProvider;

  const X({
    this.prefix = 'G',
    this.packageName = '',
    this.includeFieldsByDefault = true,
    this.nullableFieldsByDefault = false,
    this.useDefaultsProvider = false,
  });
}
