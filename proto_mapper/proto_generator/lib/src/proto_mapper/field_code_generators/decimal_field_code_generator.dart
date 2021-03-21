import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DecimalFieldCodeGenerator extends FieldCodeGenerator {
  DecimalFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  @override
  String get toProtoExpression => '$instanceReference.toString()';

  @override
  String get fromProtoNonNullableExpression =>
      'Decimal.parse(instance.$protoFieldName)';
}
