import 'package:decimal/decimal.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'field_code_generators/date_time_field_code_generator.dart';
import 'field_code_generators/decimal_field_code_generator.dart';
import 'field_code_generators/duration_field_code_generator.dart';
import 'field_code_generators/entity_field_code_generator.dart';
import 'field_code_generators/enum_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;
  final bool hasDefaultsProvider;

  MapMapBase get mapEntityAnnotation => fieldDescriptor.mapMapAnnotation;
  String get mapName => fieldDescriptor.mapName;

  FieldCodeGenerator(this.fieldDescriptor, this.hasDefaultsProvider);

  String get toMapMap =>
      '''map[\'$mapName\'] = ${fieldDescriptor.isNullable ? toNullableMapExpression : toMapExpression} ;''';

  String get _DefaultsProviderExpression {
    var ret = '''getValueOrDefault(
    map[\'$mapName\'], () => defaultsProvider.$fieldName, (mapValue) => ${fromMapExpression('mapValue')})''';
    return ret;
  }

  String get constructorMap =>
      '''$fieldName: ${fieldDescriptor.isNullable ? fromNullableMapExpression : (hasDefaultsProvider ? _DefaultsProviderExpression : fromMapExpression('map[\'$mapName\']'))},''';

  String get fromMapMap =>
      '''..$fieldName = ${fieldDescriptor.isNullable ? fromNullableMapExpression : fromMapExpression('map[\'$mapName\']')} ''';

  String get toMapExpression => 'instance.$fieldName';

  String get toNullableMapExpression => toMapExpression;

  String fromMapExpression(String sourceExpression) =>
      '$sourceExpression as ${fieldDescriptor.fieldElementTypeName}';

  String get fromNullableMapExpression =>
      '''map[\'$mapName\'] == null ? null : ${fromMapExpression('map[\'$mapName\']')}''';

  String get fieldName => fieldDescriptor.fieldElement.name;

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor, bool hasDefaultsProvider) {
    if (fieldDescriptor.fieldElementTypeName == (Decimal).toString()) {
      return DecimalFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    if (fieldDescriptor.fieldElementTypeName == (DateTime).toString()) {
      return DateTimeFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    if (fieldDescriptor.fieldElementTypeName == (Duration).toString()) {
      return DurationFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    if (fieldDescriptor.typeHasMapMapAnnotation) {
      return EntityFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreList) {
      return ListFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    if (fieldDescriptor.typeIsEnum) {
      return EnumFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
    }
    return GenericFieldCodeGenerator(fieldDescriptor, hasDefaultsProvider);
  }
}
