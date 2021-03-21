import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EntityFieldCodeGenerator extends FieldCodeGenerator {
  EntityFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor) {}

  @override
  String get toProtoExpression =>
      '${fieldDescriptor.fieldElementTypeName}ProtoMapper().toProto($instanceReference)';

  @override
  String get fromProtoNonNullableExpression =>
      '${fieldDescriptor.fieldElementTypeName}ProtoMapper().fromProto(instance.$fieldName)';
}
