import '../field_code_generator.dart';
import '../field_descriptor.dart';

class KeyFieldCodeGenerator extends FieldCodeGenerator {
  KeyFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  bool get usesKh => true;

  @override
  String get toMapMap =>
      '''\$kh.keyToMap(map, instance.$fieldName ${fieldDescriptor.isNullable ? '?? \'\' ' : ''});''';

  @override
  String fromMapExpression(String sourceExpression) =>
      '\$kh.keyFromMap(map, \'$fieldName\')';
}
