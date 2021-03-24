import 'package:build/build.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'map_map_generator_base.dart';

class MapMapGenerator extends MapMapGeneratorBase<MapMap> {
  MapMapGenerator(BuilderOptions options);

  @override
  MapMap hydrateAnnotation(ConstantReader reader) {
    var ret = MapMap(
      includeFieldsByDefault:
          reader.read('includeFieldsByDefault').literalValue as bool,
      useDefaultsProvider:
          reader.read('useDefaultsProvider').literalValue as bool,
    );
    return ret;
  }
}
