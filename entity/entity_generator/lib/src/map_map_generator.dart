import 'package:build/src/builder/builder.dart';
import 'package:entity_adapter/entity_adapter.dart';
import 'package:map_mapper_generator/map_mapper_generator.dart';
import 'package:source_gen/source_gen.dart';

class MapMapGenerator extends MapMapGeneratorBase<MapEntity> {
  MapMapGenerator(BuilderOptions options);

  @override
  MapEntity hydrateAnnotation(ConstantReader reader) {
    var ret = MapEntity(
      includeFieldsByDefault:
          reader.read('includeFieldsByDefault').literalValue as bool,
      nullableFieldsByDefault:
          reader.read('nullableFieldsByDefault').literalValue as bool,
      generateMapMapper: reader.read('generateMapMapper').literalValue as bool,
      useDefaultsProvider:
          reader.read('useDefaultsProvider').literalValue as bool,
    );
    return ret.generateMapMapper ? ret : null;
  }
}
