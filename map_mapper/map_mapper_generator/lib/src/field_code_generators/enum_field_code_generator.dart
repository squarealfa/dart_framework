import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EnumFieldCodeGenerator extends FieldCodeGenerator {
  EnumFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  String get toMapExpression => 'instance.$fieldName.index';

  @override
  String get toNullableMapExpression => 'instance.$fieldName?.index';

  @override
  String fromMapExpression(String sourceExpression) =>
      '''${fieldDescriptor.fieldElementTypeName}.values[$sourceExpression as int]''';
}
