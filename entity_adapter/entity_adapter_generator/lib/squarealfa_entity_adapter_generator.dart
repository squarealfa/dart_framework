library entity_mapper;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_adapter_generator.dart';

Builder entityAdapterBuilder(BuilderOptions options) =>
    SharedPartBuilder([EntityAdapterGenerator(options)], 'entity_adapter');
