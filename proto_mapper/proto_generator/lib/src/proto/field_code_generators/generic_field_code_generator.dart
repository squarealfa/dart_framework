import '../field_code_generator.dart';
import '../field_descriptor.dart';

class GenericFieldCodeGenerator extends FieldCodeGenerator {
  GenericFieldCodeGenerator(FieldDescriptor fieldDescriptor, int lineNumber)
      : super(fieldDescriptor, lineNumber) {}

  @override
  String get fieldType => 'string';
}
