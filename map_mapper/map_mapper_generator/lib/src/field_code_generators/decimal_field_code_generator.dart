import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DecimalFieldCodeGenerator extends FieldCodeGenerator {
  DecimalFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  String get toMapExpression => 'instance.$fieldName.toString()';

  @override
  String get toNullableMapExpression => 'instance.$fieldName?.toString()';

  @override
  String fromMapExpression(String sourceExpression) =>
      'Decimal.parse($sourceExpression)';
}
