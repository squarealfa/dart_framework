import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import 'field_code_generators/entity_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/iterable_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_code_generators/set_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;
  final BuildBuilder buildBuilder;

  String get constructorAssignment => '';

  FieldCodeGenerator(this.fieldDescriptor, this.buildBuilder);

  String get fieldType => '${fieldDescriptor.fieldElementTypeName}';

  String get fieldDeclaration => fieldDescriptor.isNullable
      ? '  $fieldType? ${fieldDescriptor.name};'
      : '''
          $fieldType? \$${fieldDescriptor.name};
          $fieldType get ${fieldDescriptor.name} =>
              \$${fieldDescriptor.name} $defaultProvided;
          set ${fieldDescriptor.name}($fieldType value) => \$${fieldDescriptor.name} = value;
      ''';

  String get defaultProvided => !buildBuilder.useDefaultsProvider
      ? '!'
      : ' ?? _defaultsProvider.${fieldDescriptor.name}';

  bool get usesDefaultsProvided =>
      buildBuilder.useDefaultsProvider && !fieldDescriptor.isNullable;

  String get toBuilderMap => '  ${fieldDescriptor.name}: $toBuilderExpression,';

  String get toBuilderExpression => 'entity.${fieldDescriptor.name}';

  String get constructorDeclaration => fieldDescriptor.isNullable
      ? 'this.${fieldDescriptor.name},'
      : '$fieldType? ${fieldDescriptor.name},';

  String get constructorStatement {
    if (fieldDescriptor.isNullable) return '';
    return '\$${fieldDescriptor.name} = ${fieldDescriptor.name};';
  }

  String get entityConstructorMap =>
      '${fieldDescriptor.name}: $constructorExpression,';

  String get constructorExpression => '${fieldDescriptor.name}';

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor, BuildBuilder buildBuilder) {
    if (fieldDescriptor.fieldElement.type.isDartCoreList) {
      return ListFieldCodeGenerator(fieldDescriptor, buildBuilder);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreSet) {
      return SetFieldCodeGenerator(fieldDescriptor, buildBuilder);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreIterable) {
      return IterableFieldCodeGenerator(fieldDescriptor, buildBuilder);
    }
    if (!fieldDescriptor.typeIsEnum &&
        fieldDescriptor.typeHasEntityMapAnnotation) {
      return EntityFieldCodeGenerator(fieldDescriptor, buildBuilder);
    }
    return GenericFieldCodeGenerator(fieldDescriptor, buildBuilder);
  }
}
