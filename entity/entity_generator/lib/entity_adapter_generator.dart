library entity_mapper;

import 'package:build/build.dart';
import './src/builder_generator/builder_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_adapter_generator.dart';
import 'src/proto_generator.dart';
import 'src/proto_mapper_generator.dart';
import 'src/validator_generator.dart';
import 'src/map_map_generator.dart';

Builder entityValidationGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValidatorGenerator()], 'entity_validation');

Builder entityProtoMapperBuilder(BuilderOptions options) =>
    SharedPartBuilder([ProtoMapperGenerator(options)], 'entity_proto_map');

Builder entityBuilder(BuilderOptions options) =>
    SharedPartBuilder([BuilderGenerator(options)], 'entity_builder');

Builder entityAdapterBuilder(BuilderOptions options) =>
    SharedPartBuilder([EntityAdapterGenerator(options)], 'entity_mapper');

Builder entityProtoBuilder(BuilderOptions options) =>
    LibraryBuilder(ProtoGenerator(options),
        generatedExtension: '.entity.proto', formatOutput: (code) => code);

Builder entityMapMapBuilder(BuilderOptions options) =>
    SharedPartBuilder([MapMapGenerator(options)], 'entity_map_map');
