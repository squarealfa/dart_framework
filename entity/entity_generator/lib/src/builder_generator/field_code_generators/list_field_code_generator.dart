import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import '../field_code_generator.dart';
import '../field_descriptor.dart';

class ListFieldCodeGenerator extends FieldCodeGenerator {
  ListFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, BuildBuilder buildBuilder)
      : super(fieldDescriptor, buildBuilder);

  @override
  String get fieldType => fieldDescriptor.parameterTypeHasEntityMapAnnotation &&
          !fieldDescriptor.parameterTypeIsEnum
      ? 'List<${fieldDescriptor.parameterTypeName}Builder>'
      : super.fieldType;

  String get _listExpression => '''
        ${fieldDescriptor.isNullable ? 'entity.${fieldDescriptor.name} == null  ? null :' : ''}
        entity.${fieldDescriptor.valueName}.map((e) => 
          ${fieldDescriptor.parameterTypeName}Builder.from${fieldDescriptor.parameterTypeName}(e)).toList()''';

  @override
  String get toBuilderExpression =>
      fieldDescriptor.parameterTypeHasEntityMapAnnotation &&
              !fieldDescriptor.parameterTypeIsEnum
          ? _listExpression
          : 'entity.${fieldDescriptor.name}';

  @override
  String get constructorExpression => fieldDescriptor
              .parameterTypeHasEntityMapAnnotation &&
          !fieldDescriptor.parameterTypeIsEnum
      ? '''${fieldDescriptor.isNullable ? '${fieldDescriptor.name} == null ? null : ' : ''} ${fieldDescriptor.valueName}.map((e) => e.build()).toList()'''
      : '${fieldDescriptor.name}';

  @override
  String get defaultProvided => ' ?? []';

  @override
  bool get usesDefaultsProvided => false;
}
