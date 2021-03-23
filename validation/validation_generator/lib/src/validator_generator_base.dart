import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_validation/squarealfa_validation.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_descriptor.dart';

abstract class ValidatorGeneratorBase<TValidatable extends ValidatableBase>
    extends GeneratorForAnnotation<TValidatable> {
  TValidatable hydrateAnnotation(ConstantReader reader);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    var validatable = hydrateAnnotation(reader);
    var createBaseClass = validatable.createValidatableBaseClass;

    try {
      return generateValidator(element, createBaseClass);
    } catch (ex, stack) {
      print('*** Exception: $ex with stack: $stack');
      rethrow;
    }
  }

  static String generateValidator(Element element, bool createBaseClass) {
    var classElement = element.asClassElement();
    if (classElement.kind.name == "ENUM") return '';
    var superTypeElement = classElement.supertype!.element;

    var annotation = TypeChecker.fromRuntime(ValidatableBase)
        .firstAnnotationOf(superTypeElement);

    var superClassIsValidatable = annotation != null;

    var className = classElement.name;

    var fieldDescriptors = _getFieldDescriptors(classElement);

    var errorCallBuffer = StringBuffer();
    var validationMethodBuffer = StringBuffer();

    for (var fieldDescriptor in fieldDescriptors) {
      var errorLine = '''
          if ((error = validate${fieldDescriptor.pascalName}(entity.${fieldDescriptor.name})) != null) {
            errors.add(error!);
          }
      ''';
      errorCallBuffer.writeln(errorLine);

      var validationMethodCode = _createValidationMethod(fieldDescriptor);
      validationMethodBuffer.writeln(validationMethodCode);
    }

    var validatorClassName =
        createBaseClass ? '${className}ValidatorBase' : '${className}Validator';

    var callToSuperCreate = superClassIsValidatable ? ' : super.create()' : '';
    var construction =
        '${className}Validator${createBaseClass ? 'Base' : ''}.create()$callToSuperCreate;';

    var singletonAndFactory = createBaseClass
        ? ''
        : '''
      static final ${className}Validator _singleton = ${className}Validator.create();
      factory ${className}Validator() => _singleton;
      ''';

    var extendsClause = !superClassIsValidatable
        ? ''
        : 'extends ${superTypeElement.name}Validator';

    var returnStatement = !superClassIsValidatable
        ? 'return ErrorList(errors);'
        : 'return ErrorList.merge(super.validate(entity), errors);';

    var ret = '''
    
    class $validatorClassName $extendsClause  implements Validator {
        
        $construction
        
        $singletonAndFactory  
        
        $validationMethodBuffer
      
        @override
        ErrorList validate(covariant $className entity) {
          var errors = <ValidationError>[];
          ValidationError? error;
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

  static String _createValidationMethod(FieldDescriptor fieldDescriptor) {
    var requiredCode = _createRequiredCode(fieldDescriptor);

    var entityCode = _createEntityCode(fieldDescriptor);

    var listCode = _createListCode(fieldDescriptor);

    var ret = '''

      ValidationError? validate${fieldDescriptor.pascalName}(${fieldDescriptor.fieldElementType.getDisplayString(withNullability: true)} value)
      {
        $requiredCode
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

    var nullEscape = fieldDescriptor.isNullable && !fieldDescriptor.hasRequired
        ? 'if (value == null) return null;'
        : '';

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
    var nullEscape = fieldDescriptor.isNullable && !fieldDescriptor.hasRequired
        ? 'value == null ? ErrorList([]) : '
        : '';

    var code = ''' 
    
        var errors = $nullEscape
          ${fieldDescriptor.fieldElementType.getDisplayString(withNullability: false)}Validator().validate(value);
        var errorListValidation = PropertyValidation(\'${fieldDescriptor.name}\', errors);

        if (errorListValidation.errorList.validationErrors.isNotEmpty) {
          return errorListValidation;
        }

    ''';
    return code;
  }

  static String _createRequiredCode(FieldDescriptor fieldDescriptor) {
    if (!fieldDescriptor.hasRequired) {
      return '';
    }
    if (fieldDescriptor.fieldElementType.isDartCoreString)
      return '''
          if (${fieldDescriptor.isNullable ? 'value?.isEmpty ?? true' : 'value.isEmpty'} )
          { 
            return RequiredValidationError(\'${fieldDescriptor.name}\');
          }
        ''';
    return '''
          if (value == null) 
            return RequiredValidationError(\'${fieldDescriptor.name}\');        
         ''';
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(ClassElement classElement) {
  final fieldSet = classElement.getSortedFieldSet(includeInherited: false);
  final fieldDescriptors =
      fieldSet.map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
          ));
  return fieldDescriptors;
}
