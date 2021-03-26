import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:tuple/tuple.dart';
import '../field_descriptor.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class RangeValidator extends PropertyValidator {
  static const _rangeFieldChecker = TypeChecker.fromRuntime(Range);

  Range? getRangeAnnotation(FieldDescriptor fieldDescriptor) {
    var annotation =
        _rangeFieldChecker.getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) {
      return null;
    }
    final minValue = annotation.getField('minValue')?.toIntValue();
    final maxValue = annotation.getField('maxValue')?.toIntValue();
    var ret = Range(
      minValue: minValue,
      maxValue: maxValue,
    );
    return ret;
  }

  @override
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  ) {
    final annotation = getRangeAnnotation(fieldDescriptor);
    if (annotation == null) {
      return createResult();
    }
    final buffer = StringBuffer();
    final nullEscape = fieldDescriptor.isNullable && !previousNullCheck
        ? 'value != null && '
        : '';
    if (annotation.minValue != null) {
      final fieldLiteral =
          _createFieldLiteral(fieldDescriptor, annotation.minValue!);
      buffer.writeln('''
          if ($nullEscape value < $fieldLiteral) {
            return RangeValidationError(\'${fieldDescriptor.name}\');
          }
      ''');
    }
    if (annotation.maxValue != null) {
      final fieldLiteral =
          _createFieldLiteral(fieldDescriptor, annotation.maxValue!);
      buffer.writeln('''
          if ($nullEscape value > $fieldLiteral) {
            return RangeValidationError(\'${fieldDescriptor.name}\');
          }
      ''');
    }
    return createResult(buffer.toString());
  }
}

String _createFieldLiteral(FieldDescriptor fieldDescriptor, int value) =>
    fieldDescriptor.fieldElementTypeName == 'Decimal'
        ? 'Decimal.fromInt($value)'
        : '$value';
