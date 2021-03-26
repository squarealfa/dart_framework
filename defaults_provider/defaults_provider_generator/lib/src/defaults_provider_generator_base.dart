import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:defaults_provider_generator/src/field_code_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_descriptor.dart';

abstract class DefaultsProviderGeneratorBase<
        TDefaultsProvider extends DefaultsProviderBase>
    extends GeneratorForAnnotation<TDefaultsProvider> {
  TDefaultsProvider hydrateAnnotation(ConstantReader reader);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    var validatable = hydrateAnnotation(reader);
    var createBaseClass = validatable.createDefaultsProviderBaseClass;

    try {
      return generateDefaultsProvider(element, createBaseClass);
    } catch (ex, stack) {
      print('*** Exception: $ex with stack: $stack');
      rethrow;
    }
  }

  static String generateDefaultsProvider(
      Element element, bool createBaseClass) {
    var classElement = element.asClassElement();
    if (classElement.kind.name == 'ENUM') return '';
    var superTypeElement = classElement.supertype!.element;

    var annotation = TypeChecker.fromRuntime(DefaultsProviderBase)
        .firstAnnotationOf(superTypeElement);

    final superClassHasDefaultsProvider = annotation != null;

    final className = classElement.name;

    final constructorFields = _getFieldDescriptors(classElement, true);
    final parameterFieldBuffer = StringBuffer();
    final constructorFieldBuffer = StringBuffer();

    for (var field in constructorFields) {
      parameterFieldBuffer
          .writeln('${field.fieldElementTypeName}? ${field.name},');
      constructorFieldBuffer
          .writeln('${field.name}: ${field.name} ?? this.${field.name},');
    }

    final propertyFields = _getFieldDescriptors(classElement, false);
    final propertyFieldBuffer = StringBuffer();

    for (var field in constructorFields) {
      if (!superClassHasDefaultsProvider ||
          propertyFields.any((element) => element.name == field.name)) {
        var gen =
            FieldCodeGenerator.fromFieldDescriptor(field, createBaseClass);
        propertyFieldBuffer.writeln(
            '''${field.fieldElementTypeName} get ${field.name} ${createBaseClass && gen.defaultExpression == '' ? '' : ' => ' + gen.defaultExpression};''');
      } else {
        propertyFieldBuffer.writeln(
            '''${field.fieldElementTypeName} get ${field.name} => _superDefaultsProvider.${field.name};''');
      }
    }

    final providerClassName =
        '${className}DefaultsProvider${createBaseClass ? 'Base' : ''}';

    final superDeclaration = superClassHasDefaultsProvider
        ? '''final _superDefaultsProvider = ${superTypeElement.name}DefaultsProvider();'''
        : '';

    final constructor = classElement.isAbstract
        ? ''
        : '''
        $className createWithDefaults({
          $parameterFieldBuffer
        }) {
          return $className(
            $constructorFieldBuffer
          );
        }
    ''';

    return '''

      ${createBaseClass ? 'abstract' : ''} class $providerClassName {
        $superDeclaration
      
        $constructor

        $propertyFieldBuffer
      
      }

    ''';
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, bool includeInherited) {
  final fieldSet =
      classElement.getSortedFieldSet(includeInherited: includeInherited);
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
          ))
      .where((element) => !element.isNullable);
  return fieldDescriptors;
}
