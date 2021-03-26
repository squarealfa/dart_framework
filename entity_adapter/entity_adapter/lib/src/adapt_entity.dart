import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';

class AdaptEntity implements MapMap, Proto, MapProto {
  final Type rootEntityType;
  const AdaptEntity({
    this.rootEntityType = Object,
    this.useDefaultsProvider = true,
    this.includeFieldsByDefault = true,
    this.prefix = 'G',
    this.packageName = '',
  });

  @override
  final bool includeFieldsByDefault;

  @override
  final bool useDefaultsProvider;

  @override
  final String packageName;

  @override
  final String? prefix;
}
