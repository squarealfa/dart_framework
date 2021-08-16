import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:tuple/tuple.dart';
import '../field_descriptor.dart';
import '../type_checker_extension.dart';
import 'property_validator.dart';

class RegularExpressionValidator extends PropertyValidator {
  static const _regularExpressionFieldChecker =
      TypeChecker.fromRuntime(RegularExpression);

  RegularExpression? getRegularExpressionAnnotation(
      FieldDescriptor fieldDescriptor) {
    var annotation = _regularExpressionFieldChecker
        .getFieldAnnotation(fieldDescriptor.fieldElement);
    if (annotation == null) {
      return null;
    }
    final expression = annotation.getField('expression')?.toStringValue() ?? '';
    var ret = RegularExpression(
      expression: expression,
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

    final annotation = getRegularExpressionAnnotation(fieldDescriptor);
    if (annotation == null) {
      return createResult();
    }

    final buffer = StringBuffer();
    final expression = annotation.expression.replaceAll('\'', '\\\'');
    final nullEscape = fieldDescriptor.isNullable && !previousNullCheck
        ? 'value != null && '
        : '';
    buffer.writeln('''
          if ($nullEscape RegExp(\'$expression\').stringMatch(value) != value) {
            return RegularExpressionValidationError(\'${fieldDescriptor.name}\', 
              expression: \'$expression\');
          }
      ''');
    return createResult(buffer.toString());
  }
}
