import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_validation/squarealfa_validation.dart';
import 'package:squarealfa_validation_generator/src/field_descriptor.dart';
import 'package:tuple/tuple.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class DoubleRangeValidator extends PropertyValidator {
  static const _doubleRangeFieldChecker = TypeChecker.fromRuntime(DoubleRange);

  DoubleRange? getDoubleRangeAnnotation(FieldDescriptor fieldDescriptor) {
    var annotation = _doubleRangeFieldChecker
        .getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) {
      return null;
    }
    final minValue = annotation.getField('minValue')?.toDoubleValue();
    final maxValue = annotation.getField('maxValue')?.toDoubleValue();
    var ret = DoubleRange(
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
    final annotation = getDoubleRangeAnnotation(fieldDescriptor);
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

String _createFieldLiteral(FieldDescriptor fieldDescriptor, double value) =>
    fieldDescriptor.fieldElementTypeName == 'Decimal'
        ? 'Decimal.parse($value.toString())'
        : '$value';
