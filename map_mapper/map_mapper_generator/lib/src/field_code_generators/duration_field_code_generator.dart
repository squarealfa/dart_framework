import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DurationFieldCodeGenerator extends FieldCodeGenerator {
  DurationFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  String get toMapExpression => 'instance.$fieldName.inMilliseconds';

  @override
  String get toNullableMapExpression => 'instance.$fieldName?.inMilliseconds';

  @override
  String fromMapExpression(String sourceExpression) =>
      'Duration(milliseconds: $sourceExpression)';
}
