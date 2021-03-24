import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_validation/squarealfa_validation.dart';
import 'package:squarealfa_validation_generator/src/field_descriptor.dart';
import 'package:tuple/tuple.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class RequiredValidator extends PropertyValidator {
  static const _requiredFieldChecker = TypeChecker.fromRuntime(Required);

  Required? getRequiredAnnotation(FieldDescriptor fieldDescriptor) {
    var annotation =
        _requiredFieldChecker.getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) return null;
    var ret = Required();
    return ret;
  }

  @override
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  ) {
    final annotation = getRequiredAnnotation(fieldDescriptor);
    if (annotation == null) {
      return createResult();
    }
    if (fieldDescriptor.fieldElementType.isDartCoreString) {
      return createResult('''
          if (${fieldDescriptor.isNullable ? 'value?.isEmpty ?? true' : 'value.isEmpty'} )
          { 
            return RequiredValidationError(\'${fieldDescriptor.name}\');
          }
        ''');
    }
    if (!fieldDescriptor.isNullable) {
      return createResult('');
    }
    return createResult('''
          if (value == null) 
          {
            return RequiredValidationError(\'${fieldDescriptor.name}\');        
          }
         ''', true);
  }
}
