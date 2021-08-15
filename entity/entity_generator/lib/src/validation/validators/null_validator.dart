import 'package:tuple/tuple.dart';
import '../field_descriptor.dart';
import 'property_validator.dart';

class NullValidator extends PropertyValidator {
  @override
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  ) {
    if (fieldDescriptor.isNullable) {
      return createResult();
    }
    return createResult('''
          if (value == null) 
          {
            return RequiredValidationError(\'${fieldDescriptor.name}\');        
          }
         ''', true);
  }
}
