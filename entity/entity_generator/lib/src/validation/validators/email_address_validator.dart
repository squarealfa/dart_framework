import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:tuple/tuple.dart';
import '../field_descriptor.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class EmailAddressValidator extends PropertyValidator {
  static const _emailAddressFieldChecker =
      TypeChecker.fromRuntime(EmailAddress);

  EmailAddress? getEmailAddressAnnotation(FieldDescriptor fieldDescriptor) {
    var annotation = _emailAddressFieldChecker
        .getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) return null;
    var ret = EmailAddress();
    return ret;
  }

  @override
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  ) {
    final annotation = getEmailAddressAnnotation(fieldDescriptor);
    if (annotation == null) {
      return createResult();
    }
    if (fieldDescriptor.fieldElementType.isDartCoreString) {
      return createResult('''
        if (${fieldDescriptor.isNullable ? '(value?.isNotEmpty ?? false)' : 'value.isNotEmpty'} && 
        !RegExp(
            r'^(([^<>()[\\]\\\\.,;:\\s@\\"]+(\\.[^<>()[\\]\\\\.,;:\\s@\\"]+)*)|(\\".+\\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))\$')
        .hasMatch(value ${fieldDescriptor.isNullable ? ' ?? \'\'' : ''})
        )
        {
          return EmailAddressValidationError(\'${fieldDescriptor.name}\');
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
