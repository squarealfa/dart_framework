import 'package:decimal/decimal.dart';
import 'package:defaults_provider_generator/src/field_code_generators/entity_field_code_generator.dart';

import 'field_code_generators/bool_time_field_code_generator.dart';
import 'field_code_generators/decimal_field_code_generator.dart';
import 'field_code_generators/double_field_code_generator.dart';
import 'field_code_generators/duration_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/int_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_code_generators/string_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;
  final bool isAbstract;

  FieldCodeGenerator(this.fieldDescriptor, this.isAbstract);

  String get defaultExpression =>
      isAbstract ? '' : 'throw UnimplementedError()';

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor, bool isAbstract) {
    if (fieldDescriptor.fieldElementType.isDartCoreString) {
      return StringFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElementType.isDartCoreInt) {
      return IntFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElementType.isDartCoreDouble) {
      return DoubleFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElementType.isDartCoreBool) {
      return BoolFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElement.type.isDartCoreList) {
      return ListFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (!fieldDescriptor.typeIsEnum &&
        fieldDescriptor.typeHasDefaultsProvider) {
      return EntityFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElementTypeName == (Decimal).toString()) {
      return DecimalFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    if (fieldDescriptor.fieldElementTypeName == (Duration).toString()) {
      return DurationFieldCodeGenerator(fieldDescriptor, isAbstract);
    }
    return GenericFieldCodeGenerator(fieldDescriptor, isAbstract);
  }
}
