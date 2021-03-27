library squarealfa_validation_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builder_generator/builder_generator.dart';
import 'src/copywith_generator/copywith_generator.dart';
import 'src/validation/validator_generator.dart';

export 'src/validation/validator_generator.dart';

Builder validationGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValidatorGenerator()], 'validation');

Builder builderBuilder(BuilderOptions options) =>
    SharedPartBuilder([BuilderGenerator(options)], 'builder_builder');

Builder copyWithBuilder(BuilderOptions options) =>
    SharedPartBuilder([CopyWithGenerator(options)], 'copywith_builder');
