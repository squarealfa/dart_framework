import 'field_code_generators/entity_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;

  FieldCodeGenerator(this.fieldDescriptor);

  String get fieldType => '${fieldDescriptor.fieldElementTypeName}';

  String get fieldDeclaration =>
      '  $fieldType${fieldDescriptor.nullSuffix} ${fieldDescriptor.name};';

  String get toBuilderMap => '  ${fieldDescriptor.name}: $toBuilderExpression,';

  String get toBuilderExpression => 'entity.${fieldDescriptor.name}';

  String get constructorDeclaration =>
      '${fieldDescriptor.requiredPrefix} this.${fieldDescriptor.name},';

  String get entityConstructorMap =>
      '${fieldDescriptor.name}: $constructorExpression,';

  String get constructorExpression => '${fieldDescriptor.name}';

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor) {
    if (fieldDescriptor.fieldElement.type.isDartCoreList) {
      return ListFieldCodeGenerator(fieldDescriptor);
    }
    if (!fieldDescriptor.typeIsEnum &&
        fieldDescriptor.typeHasEntityMapAnnotation) {
      return EntityFieldCodeGenerator(fieldDescriptor);
    }
    return GenericFieldCodeGenerator(fieldDescriptor);
  }
}
