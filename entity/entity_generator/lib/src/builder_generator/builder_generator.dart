import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_code_generator.dart';
import 'field_descriptor.dart';

class BuilderGenerator extends GeneratorForAnnotation<BuildBuilder> {
  late String _className;

  BuilderGenerator(BuilderOptions options);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    var classElement = element.asClassElement();
    if (classElement.kind.name == 'ENUM') return '';
    _className = classElement.name;

    if (classElement.kind.name == 'ENUM') return '';

    var fieldDescriptors = _getFieldDescriptors(classElement);

    if (fieldDescriptors.isEmpty) return '';

    var renderBuffer = StringBuffer();
    //renderBuffer.writeln(_renderCopyWithExtension(fieldDescriptors));

    renderBuffer.writeln(_renderBuilder(fieldDescriptors));

    return renderBuffer.toString();
  }

  String _renderBuilder(
    Iterable<FieldDescriptor> fieldDescriptors,
  ) {
    var className = _className;

    var fieldBuffer = StringBuffer();
    var assignmentBuffer = StringBuffer();
    var constructorBuffer = StringBuffer();
    var entityConstructorBuffer = StringBuffer();

    for (var fieldDescriptor in fieldDescriptors) {
      var gen = FieldCodeGenerator.fromFieldDescriptor(fieldDescriptor);

      fieldBuffer.writeln(gen.fieldDeclaration);
      constructorBuffer.writeln(gen.constructorDeclaration);
      assignmentBuffer.writeln(gen.toBuilderMap);
      entityConstructorBuffer.writeln(gen.entityConstructorMap);
    }

    var ret = '''

      class ${className}Builder implements Builder<$className> {
        $fieldBuffer

        ${className}Builder({ $constructorBuffer });

        factory ${className}Builder.from$className($className entity) {
          return ${className}Builder($assignmentBuffer);
        }
        
        
        @override
        $className build() {
          var entity = $className(
            $entityConstructorBuffer
          );
          ${className}Validator().validateThrowing(entity);
          return entity;
        }

      }

    ''';
    return ret;
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(ClassElement classElement) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors =
      fieldSet.map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
          ));
  return fieldDescriptors;
}
