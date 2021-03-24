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
    if (validatable == null) return '';
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
    if (classElement.kind.name == "ENUM") return '';
    var superTypeElement = classElement.supertype.element;

    var annotation = TypeChecker.fromRuntime(DefaultsProviderBase)
        .firstAnnotationOf(superTypeElement);

    final superClassHasDefaultsProvider = annotation != null;

    final className = classElement.name;

    final constructorFields = _getFieldDescriptors(classElement, true);
    final constructorFieldBuffer = StringBuffer();

    for (var field in constructorFields) {
      constructorFieldBuffer.writeln('${field.name}: ${field.name},');
    }

    final propertyFields = _getFieldDescriptors(classElement, false);
    final propertyFieldBuffer = StringBuffer();

    for (var field in constructorFields) {
      if (propertyFields.any((element) => element.name == field.name)) {
        var gen = FieldCodeGenerator.fromFieldDescriptor(field);
        propertyFieldBuffer.writeln(
            '${field.fieldElementTypeName} get ${field.name} => ${gen.defaultExpression};');
      } else {
        propertyFieldBuffer.writeln(
            '${field.fieldElementTypeName} get ${field.name} => _superDefaultsProvider.${field.name};');
      }
    }

    final providerClassName =
        '${className}DefaultsProvider${createBaseClass ? 'Base' : ''}';

    final superDeclaration = superClassHasDefaultsProvider
        ? 'final _superDefaultsProvider = ${superTypeElement.name}DefaultsProvider();'
        : '';

    final constructor = classElement.isAbstract
        ? ''
        : '''
        $className createWithDefaults() {
          return $className(
            $constructorFieldBuffer
          );
        }
    ''';

    return '''

      class $providerClassName {
        $superDeclaration
      
        $constructor

        $propertyFieldBuffer
      
      }

    ''';
  }
  // var errorCallBuffer = StringBuffer();
  // var validationMethodBuffer = StringBuffer();
  //
  // for (var fieldDescriptor in fieldDescriptors) {
  //   var errorLine = '''
  //       if ((error = validate${fieldDescriptor.pascalName}(entity.${fieldDescriptor.name})) != null) {
  //         errors.add(error!);
  //       }
  //   ''';
  //   errorCallBuffer.writeln(errorLine);
  //
  //   var validationMethodCode = _createValidationMethod(fieldDescriptor);
  //   validationMethodBuffer.writeln(validationMethodCode);
  // }
  //
  // var validatorClassName =
  //     createBaseClass ? '${className}ValidatorBase' : '${className}Validator';
  //
  // var callToSuperCreate =
  //     superClassIsDefaultsProvider ? ' : super.create()' : '';
  // var construction =
  //     '${className}Validator${createBaseClass ? 'Base' : ''}.create()$callToSuperCreate;';
  //
  // var singletonAndFactory = createBaseClass
  //     ? ''
  //     : '''
  //   static final ${className}Validator _singleton = ${className}Validator.create();
  //   factory ${className}Validator() => _singleton;
  //   ''';
  //
  // var extendsClause = !superClassIsDefaultsProvider
  //     ? ''
  //     : 'extends ${superTypeElement.name}Validator';
  //
  // var returnStatement = !superClassIsDefaultsProvider
  //     ? 'return ErrorList(errors);'
  //     : 'return ErrorList.merge(super.validate(entity), errors);';
  //
  // var ret = '''
  //
  // class $validatorClassName $extendsClause  implements Validator {
  //
  //     $construction
  //
  //     $singletonAndFactory
  //
  //     $validationMethodBuffer
  //
  //     @override
  //     ErrorList validate(covariant $className entity) {
  //       var errors = <ValidationError>[];
  //       ValidationError? error;
  //       $errorCallBuffer
  //
  //       $returnStatement
  //     }
  //
  //     @override
  //     void validateThrowing(covariant $className entity) {
  //       var errors = validate(entity);
  //       if (errors.validationErrors.isNotEmpty) throw errors;
  //     }
  //   }
  //
  // ''';
  // return ret;
}

//   static String _createValidationMethod(FieldDescriptor fieldDescriptor) {
//     var requiredCode = _createRequiredCode(fieldDescriptor);
//
//     var entityCode = _createEntityCode(fieldDescriptor);
//
//     var listCode = _createListCode(fieldDescriptor);
//
//     var ret = '''
//
//       ValidationError? validate${fieldDescriptor.pascalName}(${fieldDescriptor.fieldElementType.getDisplayString(withNullability: true)} value)
//       {
//         $requiredCode
//         $entityCode
//         $listCode
//         return null;
//       }
//
//     ''';
//     return ret;
//   }
//
//   static String _createListCode(FieldDescriptor fieldDescriptor) {
//     if (!fieldDescriptor.fieldElementType.isDartCoreList ||
//         !fieldDescriptor.parameterTypeIsValidatable ||
//         fieldDescriptor.parameterTypeIsEnum) return '';
//
//     var nullEscape = fieldDescriptor.isNullable && !fieldDescriptor.hasRequired
//         ? 'if (value == null) return null;'
//         : '';
//
//     var code = '''
//
//       $nullEscape
//
//       var errorLists = value.map((entity) {
//         var errors = ${fieldDescriptor.listParameterType.getDisplayString(withNullability: false)}Validator().validate(entity);
//         var itemErrors = ListItemErrorList(value, entity, errors);
//         return itemErrors;
//       }).where((p) => p.errorList.validationErrors.isNotEmpty).toList();
//
//       if (errorLists.isNotEmpty) {
//         return ListPropertyValidation(\'${fieldDescriptor.name}\', errorLists);
//       }
//
//
//     ''';
//     return code;
//   }
//
//   static String _createEntityCode(FieldDescriptor fieldDescriptor) {
//     if (!fieldDescriptor.typeIsValidatable || fieldDescriptor.typeIsEnum) {
//       return '';
//     }
//     var nullEscape = fieldDescriptor.isNullable && !fieldDescriptor.hasRequired
//         ? 'value == null ? ErrorList([]) : '
//         : '';
//
//     var code = '''
//
//         var errors = $nullEscape
//           ${fieldDescriptor.fieldElementType.getDisplayString(withNullability: false)}Validator().validate(value);
//         var errorListValidation = PropertyValidation(\'${fieldDescriptor.name}\', errors);
//
//         if (errorListValidation.errorList.validationErrors.isNotEmpty) {
//           return errorListValidation;
//         }
//
//     ''';
//     return code;
//   }
//
//   static String _createRequiredCode(FieldDescriptor fieldDescriptor) {
//     if (!fieldDescriptor.hasRequired) {
//       return '';
//     }
//     if (fieldDescriptor.fieldElementType.isDartCoreString)
//       return '''
//           if (${fieldDescriptor.isNullable ? 'value?.isEmpty ?? true' : 'value.isEmpty'} )
//           {
//             return RequiredValidationError(\'${fieldDescriptor.name}\');
//           }
//         ''';
//     return '''
//           if (value == null)
//             return RequiredValidationError(\'${fieldDescriptor.name}\');
//          ''';
//   }
// }
//
Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, bool includeInherited) {
  final fieldSet =
      classElement.getSortedFieldSet(includeInherited: includeInherited);
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement,
          ))
      .where((element) => !element.isNullable);
  return fieldDescriptors;
}
