import 'package:decimal/decimal.dart';
import 'package:defaults_provider_generator/src/field_code_generators/entity_field_code_generator.dart';

import 'field_code_generators/bool_time_field_code_generator.dart';
import 'field_code_generators/decimal_field_code_generator.dart';
import 'field_code_generators/duration_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/int_field_code_generator.dart';
import 'field_code_generators/list_field_code_generator.dart';
import 'field_code_generators/string_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;

  FieldCodeGenerator(this.fieldDescriptor);

  get defaultExpression => 'throw UnimplementedError()';

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor) {
    if (fieldDescriptor.fieldElementType.isDartCoreString)
      return StringFieldCodeGenerator(fieldDescriptor);
    if (fieldDescriptor.fieldElementType.isDartCoreInt)
      return IntFieldCodeGenerator(fieldDescriptor);
    if (fieldDescriptor.fieldElementType.isDartCoreBool)
      return BoolFieldCodeGenerator(fieldDescriptor);
    if (fieldDescriptor.fieldElement.type.isDartCoreList)
      return ListFieldCodeGenerator(fieldDescriptor);
    if (!fieldDescriptor.typeIsEnum && fieldDescriptor.typeHasDefaultsProvider)
      return EntityFieldCodeGenerator(fieldDescriptor);
    if (fieldDescriptor.fieldElementTypeName == (Decimal).toString())
      return DecimalFieldCodeGenerator(fieldDescriptor);
    if (fieldDescriptor.fieldElementTypeName == (Duration).toString())
      return DurationFieldCodeGenerator(fieldDescriptor);
    return GenericFieldCodeGenerator(fieldDescriptor);
  }
}
