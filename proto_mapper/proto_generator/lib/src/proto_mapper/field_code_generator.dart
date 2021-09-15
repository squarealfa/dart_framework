import 'package:decimal/decimal.dart';

import 'package:proto_annotations/proto_annotations.dart';
import 'field_code_generators/bool_field_code_generator.dart';
import 'field_code_generators/datetime_field_code_generator.dart';
import 'field_code_generators/decimal_field_code_generator.dart';
import 'field_code_generators/duration_field_code_generator.dart';
import 'field_code_generators/entity_field_code_generator.dart';
import 'field_code_generators/enum_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/int_field_code_generator.dart';
import 'field_code_generators/iterable_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_code_generators/set_field_code_generator.dart';
import 'field_code_generators/string_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;

  MapProto get mapProtoBase => fieldDescriptor.protoMapperAnnotation;

  FieldCodeGenerator(this.fieldDescriptor);

  String get toProtoMap => fieldDescriptor.isNullable
      ? '''
        if (instance.$fieldName != null) {
          proto.$protoFieldName = $toProtoNullableExpression; 
        }
        $hasValueToProtoMap;
      '''
      : 'proto.$protoFieldName = $toProtoExpression;';

  String get hasValueToProtoMap =>
      'proto.${protoFieldName}HasValue = instance.$fieldName != null';

  String get instanceReference =>
      'instance.$fieldName${fieldDescriptor.isNullable ? '!' : ''}';
  String get toProtoExpression => instanceReference;
  String get toProtoNullableExpression => toProtoExpression;

/* Checked **/

  String get fromProtoMap => '$fieldName = $fromProtoExpression';
  String get constructorMap => '$fieldName: $fromProtoExpression, ';

  String get fromProtoExpression {
    if (fieldDescriptor.isNullable) return fromProtoNullableExpression;
    return fromProtoNonNullableExpression;
  }

  String get fromProtoNullableExpression =>
      '''(instance.${protoFieldName}HasValue ? ($fromProtoNonNullableExpression) : null)''';

  String get fromProtoNonNullableExpression => 'instance.$protoFieldName';

  String get fieldName => fieldDescriptor.fieldElement.name;
  String get protoFieldName => fieldDescriptor.protoFieldName;

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor) {
    if (fieldDescriptor.fieldElement.type.isDartCoreString) {
      return StringFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreBool) {
      return BoolFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreInt) {
      return IntFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreList) {
      return ListFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreSet) {
      return SetFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.typeIsEnum) {
      return EnumFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElementTypeName == (DateTime).toString()) {
      return DateTimeFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElementTypeName == (Decimal).toString()) {
      return DecimalFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElementTypeName == (Duration).toString()) {
      return DurationFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.typeHasMapProtoAnnotation) {
      return EntityFieldCodeGenerator(fieldDescriptor);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreIterable &&
        fieldDescriptor.iterableParameterType != null) {
      return IterableFieldCodeGenerator(fieldDescriptor);
    }

    return GenericFieldCodeGenerator(fieldDescriptor);
  }
}
