import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

class EntityAdapted
    implements
        MapMap,
        Proto,
        MapProto,
        DefaultsProvider,
        Validatable,
        BuildBuilder,
        CopyWith {
  final Type rootEntityType;
  const EntityAdapted({
    this.rootEntityType = Object,
    this.useDefaultsProvider = true,
    this.includeFieldsByDefault = true,
    this.prefix = 'G',
    this.packageName = '',
    this.createDefaultsProviderBaseClass = false,
    this.createValidatableBaseClass = false,
  });

  @override
  final bool includeFieldsByDefault;

  @override
  final bool useDefaultsProvider;

  @override
  final String packageName;

  @override
  final String? prefix;

  @override
  final bool createDefaultsProviderBaseClass;

  @override
  final bool createValidatableBaseClass;
}
