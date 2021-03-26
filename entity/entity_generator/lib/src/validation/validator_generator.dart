import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import 'validator_generator_base.dart';

class ValidatorGenerator extends ValidatorGeneratorBase<Validatable> {
  @override
  Validatable hydrateAnnotation(ConstantReader reader) {
    var validatable = Validatable(
      createValidatableBaseClass:
          reader.read('createValidatableBaseClass').literalValue as bool? ??
              false,
    );
    return validatable;
  }
}
