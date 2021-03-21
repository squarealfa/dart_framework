import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EnumFieldCodeGenerator extends FieldCodeGenerator {
  String? _prefix;
  EnumFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor) {
    _prefix = fieldDescriptor.prefix;
  }

  @override
  String get fromProtoNonNullableExpression =>
      '${fieldDescriptor.fieldElementTypeName}.values[instance.$fieldName.value]';

  @override
  String get toProtoExpression =>
      '''$_prefix${fieldDescriptor.fieldElementTypeName}
    .valueOf($instanceReference.index)!''';
}
