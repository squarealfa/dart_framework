import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator/src/proto/field_code_generators/double_field_code_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'field_code_generators/bool_field_code_generator.dart';
import 'field_code_generators/datetime_field_code_generator.dart';
import 'field_code_generators/duration_field_code_generator.dart';
import 'field_code_generators/entity_field_code_generator.dart';
import 'field_code_generators/generic_field_code_generator.dart';
import 'field_code_generators/int_field_code_generator.dart';
import 'field_code_generators/string_field_code_generator.dart';
import 'field_descriptor.dart';

abstract class FieldCodeGenerator {
  final FieldDescriptor fieldDescriptor;
  final int lineNumber;

  FieldCodeGenerator(this.fieldDescriptor, this.lineNumber);

  String get fieldLine =>
      '$fieldType ${fieldDescriptor.protoFieldName} = $lineNumber;';

  String? get hasValueLine => fieldDescriptor.isNullable
      ? 'bool ${fieldDescriptor.protoFieldName}HasValue = ${lineNumber + 1};'
      : null;

  String? get fieldType;

  factory FieldCodeGenerator.fromFieldDescriptor(
      FieldDescriptor fieldDescriptor, int lineNumber, String filePrefix) {
    var type = fieldDescriptor.itemType;
    var typeName =
        fieldDescriptor.itemType.getDisplayString(withNullability: false);

    if (type.isDartCoreString) {
      return StringFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (type.isDartCoreBool) {
      return BoolFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (type.isDartCoreInt) {
      return IntFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (type.isDartCoreDouble) {
      return DoubleFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (typeName == (DateTime).toString()) {
      return DateTimeFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (typeName == (Duration).toString()) {
      return DurationFieldCodeGenerator(fieldDescriptor, lineNumber);
    }
    if (TypeChecker.fromRuntime(ProtoBase).firstAnnotationOf(type.element!) !=
        null) {
      return EntityFieldCodeGenerator(fieldDescriptor, lineNumber, filePrefix);
    }
    return GenericFieldCodeGenerator(fieldDescriptor, lineNumber);
  }
}
