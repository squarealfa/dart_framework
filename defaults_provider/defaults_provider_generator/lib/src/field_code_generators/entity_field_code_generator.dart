import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EntityFieldCodeGenerator extends FieldCodeGenerator {
  EntityFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  @override
  get defaultExpression =>
      '${fieldDescriptor.fieldElementTypeName}DefaultsProvider().createWithDefaults()';
}
