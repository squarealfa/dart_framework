library map_mapper_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/map_map_generator.dart';

export 'src/map_map_generator_base.dart';

Builder mapMapBuilder(BuilderOptions options) =>
    SharedPartBuilder([MapMapGenerator(options)], 'map_map');
