import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_validation_generator/squarealfa_validation_generator.dart';
import 'package:entity_adapter/entity_adapter.dart';

class ValidatorGenerator extends ValidatorGeneratorBase<MapEntity> {
  @override
  MapEntity hydrateAnnotation(ConstantReader reader) {
    var validatable = MapEntity(
      generateValidator:
          reader.read('generateValidator').literalValue as bool ?? true,
      createValidatableBaseClass:
          reader.read('createValidatableBaseClass').literalValue as bool ??
              false,
    );
    return validatable.generateValidator ? validatable : null;
  }
}
