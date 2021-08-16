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
    final annotation = _hydrateAnnotation(reader);
    var classElement = element.asClassElement();
    if (classElement.kind.name == 'ENUM') return '';
    _className = classElement.name;

    if (classElement.kind.name == 'ENUM') return '';

    var fieldDescriptors = _getFieldDescriptors(classElement);

    if (fieldDescriptors.isEmpty) return '';

    var renderBuffer = StringBuffer();

    renderBuffer.writeln(_renderBuilder(annotation, fieldDescriptors));

    return renderBuffer.toString();
  }

  String _renderBuilder(
    BuildBuilder builder,
    Iterable<FieldDescriptor> fieldDescriptors,
  ) {
    final className = _className;
    final builderClassName =
        '${className}Builder${builder.createBuilderBaseClass ? 'Base' : ''}';

    final fieldBuffer = StringBuffer();
    final assignmentBuffer = StringBuffer();
    final constructorBuffer = StringBuffer();
    final constructorStatementBuffer = StringBuffer();
    final entityConstructorBuffer = StringBuffer();
    var usesDefaultsProvider = false;

    for (var fieldDescriptor in fieldDescriptors) {
      var gen = FieldCodeGenerator.fromFieldDescriptor(
        fieldDescriptor,
        builder,
      );

      usesDefaultsProvider = usesDefaultsProvider || gen.usesDefaultsProvided;

      fieldBuffer.writeln(gen.fieldDeclaration);
      constructorBuffer.writeln(gen.constructorDeclaration);
      final constructorStatement = gen.constructorStatement;
      if (constructorStatement.isNotEmpty) {
        constructorStatementBuffer.writeln(constructorStatement);
      }
      assignmentBuffer.writeln(gen.toBuilderMap);
      entityConstructorBuffer.writeln(gen.entityConstructorMap);
    }

    final extensionClass = builder.createBuilderBaseClass
        ? '''
          extension ${className}BuilderExtension on $className {
        $className rebuild() {
          final builder = ${className}Builder.from$className(this);
          final entity = builder.build();
          return entity;
        }
      }
    '''
        : '';

    final defaultsProvider = usesDefaultsProvider
        ? 'final _defaultsProvider = ${className}DefaultsProvider();'
        : '';

    final constructorStatement = constructorStatementBuffer.isEmpty
        ? ';'
        : '''{
          $constructorStatementBuffer
        }''';

    var ret = '''

      class $builderClassName implements Builder<$className> {

        $defaultsProvider

        $fieldBuffer

        $builderClassName({ $constructorBuffer }) $constructorStatement

        $builderClassName.from$className($className entity) 
          : this($assignmentBuffer);        
        
        @override
        $className build() {
          var entity = $className(
            $entityConstructorBuffer
          );
          const ${className}Validator().validateThrowing(entity);
          return entity;
        }

      }

      $extensionClass

    ''';
    return ret;
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(ClassElement classElement) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors =
      fieldSet.map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement,
          ));
  return fieldDescriptors;
}

BuildBuilder _hydrateAnnotation(ConstantReader reader) {
  var validatable = BuildBuilder(
      createBuilderBaseClass: reader.read('createBuilderBaseClass').boolValue,
      useDefaultsProvider: reader.read('useDefaultsProvider').boolValue);
  return validatable;
}
