import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:squarealfa_validation/squarealfa_validation.dart';

class MapEntity
    implements
        ValidatableBase,
        MapProtoBase,
        ProtoBase,
        DefaultsProvider,
        MapMapBase {
  final String packageName;
  final String prefix;
  final bool includeFieldsByDefault;
  final bool nullableFieldsByDefault;
  final bool generateProtoMapper;
  final bool generateMapMapper;
  final bool generateProto;
  final bool generateValidator;
  final bool emptyNotNullFieldsByDefault;
  final bool createValidatableBaseClass;
  final bool createDefaultsProviderBaseClass;
  final bool useDefaultsProvider;

  const MapEntity({
    this.prefix = '',
    this.packageName = '',
    this.includeFieldsByDefault = true,
    this.nullableFieldsByDefault = false,
    this.emptyNotNullFieldsByDefault = false,
    this.generateProtoMapper = true,
    this.generateMapMapper = true,
    this.generateProto = true,
    this.generateValidator = true,
    this.createValidatableBaseClass = false,
    this.createDefaultsProviderBaseClass = false,
    this.useDefaultsProvider = true,
  });
}

const mapEntity = MapEntity();
