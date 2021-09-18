import '../field_code_generator.dart';
import '../field_descriptor.dart';

class ListFieldCodeGenerator extends FieldCodeGenerator {
  ListFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider)
      : super(fieldDescriptor, hasDefaultsProvider);

  @override
  bool get usesKh =>
      fieldDescriptor.parameterTypeHasMapMapAnnotation &&
      !fieldDescriptor.parameterTypeIsEnum;

  String _toMapExpression(bool isNullable) {
    if (fieldDescriptor.parameterTypeHasMapMapAnnotation) {
      final nullEscape = isNullable
          ? 'instance.$fieldName == null ? null : instance.$fieldName!'
          : 'instance.$fieldName';
      return '''$nullEscape.map((e) => const \$${fieldDescriptor.parameterTypeName}MapMapper().toMap(e ${fieldDescriptor.parameterTypeIsEnum ? '' : ', \$kh'})).toList()''';
    }
    return '''instance.$fieldName${fieldDescriptor.fieldElementType.isDartCoreList ? '' : isNullable ? '?.toList()' : '.toList()'}''';
  }

  @override
  String get fieldNamesClassGetter =>
      fieldDescriptor.parameterTypeHasMapMapAnnotation &&
              !fieldDescriptor.parameterTypeIsEnum
          ? ''' 
        \$${fieldDescriptor.parameterTypeName}FieldNames get $fieldName =>
             \$${fieldDescriptor.parameterTypeName}FieldNames(
               keyHandler: keyHandler,
               fieldName: prefix + _$fieldName,
              );
        '''
          : super.fieldNamesClassGetter;

  @override
  String get toMapExpression => _toMapExpression(false);

  @override
  String get toNullableMapExpression => _toMapExpression(true);

  String get _fromMapConversion {
    if (fieldDescriptor.parameterTypeHasMapMapAnnotation) {
      return '''.map((e) => const \$${fieldDescriptor.parameterTypeName}MapMapper().fromMap(e ${fieldDescriptor.parameterTypeIsEnum ? '' : ', \$kh'}))''';
    }
    return '';
  }

  @override
  String fromMapExpression(String sourceExpression) =>
      '''List<${fieldDescriptor.parameterTypeName}>.unmodifiable($sourceExpression$_fromMapConversion)''';

  @override
  String get fromNullableMapExpression =>
      '''map[\'$fieldName\'] == null ? null : ${fromMapExpression('map[\'$fieldName\']')}''';
}
