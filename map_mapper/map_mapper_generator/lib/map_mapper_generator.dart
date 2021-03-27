/// Generates code that maps (converts) between instances of business
/// classes to Map<String, dynamic> and back.

library map_mapper_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/map_map_generator.dart';

Builder mapMapBuilder(BuilderOptions options) =>
    SharedPartBuilder([MapMapGenerator()], 'map_map');
