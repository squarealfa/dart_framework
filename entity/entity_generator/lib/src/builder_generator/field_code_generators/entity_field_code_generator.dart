import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EntityFieldCodeGenerator extends FieldCodeGenerator {
  EntityFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  @override
  String get fieldType => '${fieldDescriptor.fieldElementTypeName}Builder';

  @override
  String get toBuilderExpression => fieldDescriptor.isNullable
      ? 'entity.${fieldDescriptor.name} == null ? null : ${fieldDescriptor.fieldElementTypeName}Builder.from${fieldDescriptor.fieldElementTypeName}(entity.${fieldDescriptor.name}!)'
      : '${fieldDescriptor.fieldElementTypeName}Builder.from${fieldDescriptor.fieldElementTypeName}(entity.${fieldDescriptor.name})';

  @override
  String get constructorExpression =>
      '${fieldDescriptor.name}${fieldDescriptor.isNullable ? '?' : ''}.build()';
}
