import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

/// Annotation that instructs several code generators to
/// generate added features to PODO classes.
///
/// As an annotation, it is a substitute for applying
/// the [MapMap], the [Proto], the [MapProto], the
/// [DefaultsProvider], the [Validatable], the [BuildBuilder]
/// and the [CopyWith] attributes, driving all the corresponding
/// code generators to generate code as if driven by those attributes.
///
/// Additionally, this class also has an added property, [rootEntityType]
/// that drives further code generation when [EntityAdapted] is
/// applied to subclasses of [rootEntityType], like an [EntityAdapter]
/// and an [EntityPermissions] subclass.
class EntityAdapted
    implements
        MapMap,
        Proto,
        MapProto,
        DefaultsProvider,
        Validatable,
        BuildBuilder,
        CopyWith {
  /// Type that constitutes the root of an
  /// object graph that is to be communicated
  /// and to be persisted. Extra code is generated
  /// for PODOs to which the [EntityAdapted] is
  /// applied to as an annotation as long as those
  /// PODOs are a subclass of [rootEntityType].
  ///
  /// For each PODO that is a subclass of [rootEntityType],
  /// a subclass of [EntityAdapted], containing a facade to
  /// the extra features of the PODO is generated. A subclass
  /// of [EntityPermissions] is also generated containing the
  /// CRUD permissions of that PODO.
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
