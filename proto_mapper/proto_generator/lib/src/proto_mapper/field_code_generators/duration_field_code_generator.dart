import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DurationFieldCodeGenerator extends FieldCodeGenerator {
  DurationFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  @override
  String get toProtoExpression =>
      '''$instanceReference.inMilliseconds.toDouble()''';

  @override
  String get fromProtoNonNullableExpression =>
      '''Duration(milliseconds: instance.$fieldName.toInt())''';
}
