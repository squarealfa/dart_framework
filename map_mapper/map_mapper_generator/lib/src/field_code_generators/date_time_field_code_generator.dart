import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DateTimeFieldCodeGenerator extends FieldCodeGenerator {
  DateTimeFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  String get toMapExpression => 'instance.$fieldName.toIso8601String()';

  @override
  String get toNullableMapExpression =>
      'instance.$fieldName?.toIso8601String()';

  @override
  String fromMapExpression(String sourceExpression) =>
      'DateTime.parse($sourceExpression)';
}
