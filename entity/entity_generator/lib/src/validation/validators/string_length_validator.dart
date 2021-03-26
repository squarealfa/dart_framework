import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:tuple/tuple.dart';
import '../field_descriptor.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class StringLengthValidator extends PropertyValidator {
  static const _stringLengthFieldChecker =
      TypeChecker.fromRuntime(StringLength);

  StringLength? getStringLengthAnnotation(FieldDescriptor fieldDescriptor) {
    var annotation = _stringLengthFieldChecker
        .getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) {
      return null;
    }
    final minLength = annotation.getField('minLength')?.toIntValue();
    final maxLength = annotation.getField('maxLength')?.toIntValue();
    var ret = StringLength(
      minLength: minLength,
      maxLength: maxLength,
    );
    return ret;
  }

  @override
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  ) {
    if (!fieldDescriptor.fieldElementType.isDartCoreString) {
      return createResult();
    }

    final annotation = getStringLengthAnnotation(fieldDescriptor);
    if (annotation == null) {
      return createResult();
    }

    final buffer = StringBuffer();
    final nullEscape = fieldDescriptor.isNullable && !previousNullCheck
        ? 'value != null && '
        : '';
    if (annotation.minLength != null) {
      buffer.writeln('''
          if ($nullEscape value.length < ${annotation.minLength}) {
            return StringLengthValidationError(\'${fieldDescriptor.name}\');
          }
      ''');
    }
    if (annotation.maxLength != null) {
      buffer.writeln('''
          if ($nullEscape value.length > ${annotation.maxLength}) {
            return StringLengthValidationError(\'${fieldDescriptor.name}\');
          }
      ''');
    }
    return createResult(buffer.toString());
  }
}
