import '../field_code_generator.dart';
import '../field_descriptor.dart';

class ListFieldCodeGenerator extends FieldCodeGenerator {
  ListFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  String _toMapExpression(bool isNullable) {
    if (fieldDescriptor.parameterTypeHasMapMapAnnotation) {
      final nullEscape = isNullable
          ? 'instance.$fieldName == null ? null : instance.$fieldName!'
          : 'instance.$fieldName';
      return '''$nullEscape.map((e) => ${fieldDescriptor.parameterTypeName}MapMapper().toMap(e)).toList();''';
    }
    return 'instance.$fieldName;';
  }

  @override
  String get toMapExpression => _toMapExpression(false);

  @override
  String get toNullableMapExpression => _toMapExpression(true);

  String get _fromMapConversion {
    if (fieldDescriptor.parameterTypeHasMapMapAnnotation) {
      return '''.map((e) => ${fieldDescriptor.parameterTypeName}MapMapper().fromMap(e))''';
    }
    return '';
  }

  @override
  String fromMapExpression(String sourceExpression) =>
      '''List<${fieldDescriptor.parameterTypeName}>.from($sourceExpression$_fromMapConversion)''';

  @override
  String get fromNullableMapExpression =>
      '''map[\'$fieldName\'] == null ? null : ${fromMapExpression('map[\'$fieldName\']')}''';
  //'(map[\'$fieldName\'] ?? []).map((e) => ${fieldDescriptor.parameterTypeName}MapMapper().fromMap(e)).toList()';
}
