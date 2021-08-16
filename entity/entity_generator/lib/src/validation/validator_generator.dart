import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:squarealfa_entity_generator/src/validation/validators/regular_expression_validator.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_descriptor.dart';
import 'validators/double_range_validator.dart';
import 'validators/email_address_validator.dart';
import 'validators/property_validator.dart';
import 'validators/range_validator.dart';
import 'validators/required_validator.dart';
import 'validators/string_length_validator.dart';

class ValidatorGenerator extends GeneratorForAnnotation<Validatable> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    final validatable = _hydrateAnnotation(reader);
    final createBaseClass = validatable.createValidatableBaseClass;

    try {
      return generateValidator(element, createBaseClass);
    } catch (ex, stack) {
      print('*** Exception: $ex with stack: $stack');
      rethrow;
    }
  }

  static String generateValidator(Element element, bool createBaseClass) {
    var classElement = element.asClassElement();
    if (classElement.kind.name == 'ENUM') return '';
    var superTypeElement = classElement.supertype!.element;

    var annotation = TypeChecker.fromRuntime(Validatable)
        .firstAnnotationOf(superTypeElement);

    var superClassIsValidatable = annotation != null;

    var className = classElement.name;

    var fieldDescriptors = _getFieldDescriptors(classElement);

    var errorCallBuffer = StringBuffer();
    var validationMethodBuffer = StringBuffer();
    final nullValidationMethodBuffer = StringBuffer();

    for (var fieldDescriptor in fieldDescriptors) {
      var errorLine = '''
          if ((error = validate${fieldDescriptor.pascalName}(entity.${fieldDescriptor.name}, entity: entity)) != null) {
            errors.add(error!);
          }
      ''';
      errorCallBuffer.writeln(errorLine);

      var validationMethodCode =
          _createValidationMethod(fieldDescriptor, className);
      validationMethodBuffer.writeln(validationMethodCode);

      final nullValidationMethodCode =
          _createNullValidationMethod(fieldDescriptor, className);
      if (nullValidationMethodCode.isNotEmpty) {
        nullValidationMethodBuffer.writeln(nullValidationMethodCode);
      }
    }

    var validatorClassName =
        createBaseClass ? '${className}ValidatorBase' : '${className}Validator';

    var construction =
        '''const ${className}Validator${createBaseClass ? 'Base' : ''}();''';

    var extendsClause = !superClassIsValidatable
        ? ''
        : 'extends ${superTypeElement.name}Validator';

    var returnStatement = !superClassIsValidatable
        ? 'return ErrorList(errors);'
        : 'return ErrorList.merge(super.validate(entity), errors);';

    var ret = '''
    
    class $validatorClassName $extendsClause  implements Validator {
        
        $construction
        
        $validationMethodBuffer

        $nullValidationMethodBuffer
      
        @override
        ErrorList validate(covariant $className entity) {
          var errors = <ValidationError>[];

          ${errorCallBuffer.isNotEmpty ? 'ValidationError? error;' : ''}
          $errorCallBuffer
      
          $returnStatement
        }
        
        @override
        void validateThrowing(covariant $className entity) {
          var errors = validate(entity);
          if (errors.validationErrors.isNotEmpty) throw errors;
        }
      }
    
    ''';
    return ret;
  }

  static String _createNullValidationMethod(
      FieldDescriptor fieldDescriptor, String className) {
    if (fieldDescriptor.isNullable) {
      return '';
    }
    final nullValidationMethodCode = '''
            ValidationError? \$validate${fieldDescriptor.pascalName}(${fieldDescriptor.fieldElementTypeName}? value, {$className? entity})
    {
      if (value == null) {
        return RequiredValidationError('${fieldDescriptor.name}');
      }
      return validate${fieldDescriptor.pascalName}(value, entity: entity);
    }
    
    ''';
    return nullValidationMethodCode;
  }

  static String _createValidationMethod(
    FieldDescriptor fieldDescriptor,
    String className,
  ) {
    final validators = <PropertyValidator>[
      RequiredValidator(),
      StringLengthValidator(),
      RegularExpressionValidator(),
      RangeValidator(),
      DoubleRangeValidator(),
      EmailAddressValidator(),
    ];

    var propValidation = StringBuffer();
    var previousNullCheck = false;
    for (var validator in validators) {
      final result =
          validator.createValidatorCode(fieldDescriptor, previousNullCheck);
      if (result.item2) {
        previousNullCheck = true;
      }
      propValidation.writeln(result.item1);
    }

    var entityCode = _createEntityCode(fieldDescriptor);

    var listCode = _createListCode(fieldDescriptor);

    var ret = '''

      ValidationError? validate${fieldDescriptor.pascalName}(${fieldDescriptor.fieldElementType.getDisplayString(withNullability: true)} value, {$className? entity})
      {
        $propValidation

        $entityCode
        $listCode
        return null;
      }
      
    ''';
    return ret;
  }

  static String _createListCode(FieldDescriptor fieldDescriptor) {
    if (!fieldDescriptor.fieldElementType.isDartCoreList ||
        !fieldDescriptor.parameterTypeIsValidatable ||
        fieldDescriptor.parameterTypeIsEnum) return '';

    var nullEscape =
        fieldDescriptor.isNullable ? 'if (value == null) return null;' : '';

    var code = '''     

      $nullEscape
  
      var errorLists = value.map((entity) {
        var errors = ${fieldDescriptor.listParameterType!.getDisplayString(withNullability: false)}Validator().validate(entity);
        var itemErrors = ListItemErrorList(value, entity, errors);
        return itemErrors;
      }).where((p) => p.errorList.validationErrors.isNotEmpty).toList();
      
      if (errorLists.isNotEmpty) {
        return ListPropertyValidation(\'${fieldDescriptor.name}\', errorLists);
      }


    ''';
    return code;
  }

  static String _createEntityCode(FieldDescriptor fieldDescriptor) {
    if (!fieldDescriptor.typeIsValidatable || fieldDescriptor.typeIsEnum) {
      return '';
    }
    var nullEscape = fieldDescriptor.isNullable
        ? 'if (value == null) { return null; } '
        : '';

    var code = ''' 
        $nullEscape

        var errors = 
          ${fieldDescriptor.fieldElementType.getDisplayString(withNullability: false)}Validator().validate(value);
        var errorListValidation = PropertyValidation(\'${fieldDescriptor.name}\', errors);

        if (errorListValidation.errorList.validationErrors.isNotEmpty) {
          return errorListValidation;
        }

    ''';
    return code;
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(ClassElement classElement) {
  final fieldSet = classElement.getSortedFieldSet(includeInherited: false);
  final fieldDescriptors =
      fieldSet.map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement,
          ));
  return fieldDescriptors;
}

Validatable _hydrateAnnotation(ConstantReader reader) {
  var validatable = Validatable(
    createValidatableBaseClass:
        reader.read('createValidatableBaseClass').literalValue as bool? ??
            false,
  );
  return validatable;
}
