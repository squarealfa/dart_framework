import '../field_code_generator.dart';
import '../field_descriptor.dart';

class DoubleFieldCodeGenerator extends FieldCodeGenerator {
  DoubleFieldCodeGenerator(FieldDescriptor fieldDescriptor, int lineNumber)
      : super(fieldDescriptor, lineNumber);

  @override
  String get fieldType => 'double';
}
