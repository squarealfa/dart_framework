import 'package:analyzer/dart/constant/value.dart';
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

    final minValue = getFieldValue(annotation, 'minValue');
    final maxValue = getFieldValue(annotation, 'maxValue');
    var ret = Range(
      minValue: minValue,
      maxValue: maxValue,
    );
    return ret;
  }

  dynamic getFieldValue(DartObject annotation, String fieldName) {
    final fieldValue = annotation.getField(fieldName);
    if (fieldValue == null) {
      return null;
    }
    final type = fieldValue.type;
    if (type == null) return null;

    if (type.isDartCoreInt) {
      return fieldValue.toIntValue();
    }
    if (type.isDartCoreDouble) {
      return fieldValue.toDoubleValue();
    }
    return null;
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

    final minFieldLiteral = annotation.minValue == null
        ? 'null'
        : _createFieldLiteral(fieldDescriptor, annotation.minValue!);
    final maxFieldLiteral = annotation.maxValue == null
        ? 'null'
        : _createFieldLiteral(fieldDescriptor, annotation.maxValue!);

    if (annotation.minValue != null) {
      buffer.writeln('''
          if ($nullEscape value < $minFieldLiteral) {
            return RangeValidationError(\'${fieldDescriptor.name}\', value: value, minValue: $minFieldLiteral, maxValue: $maxFieldLiteral);
          }
      ''');
    }
    if (annotation.maxValue != null) {
      buffer.writeln('''
          if ($nullEscape value > $maxFieldLiteral) {
            return RangeValidationError(\'${fieldDescriptor.name}\', value: value, minValue: $minFieldLiteral, maxValue: $maxFieldLiteral);
          }
      ''');
    }
    return createResult(buffer.toString());
  }
}

String _createFieldLiteral(FieldDescriptor fieldDescriptor, Object value) =>
    fieldDescriptor.fieldElementTypeName == 'Decimal'
        ? 'Decimal.fromInt($value)'
        : '$value';
