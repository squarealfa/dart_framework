library squarealfa_validation_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/validator_generator.dart';

export 'src/validator_generator.dart';
export 'src/validator_generator_base.dart';

Builder validationGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValidatorGenerator()], 'validation');
