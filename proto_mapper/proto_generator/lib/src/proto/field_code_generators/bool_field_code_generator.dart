import '../field_code_generator.dart';
import '../field_descriptor.dart';

class BoolFieldCodeGenerator extends FieldCodeGenerator {
  BoolFieldCodeGenerator(FieldDescriptor fieldDescriptor, int lineNumber)
      : super(fieldDescriptor, lineNumber);

  @override
  String get fieldType => 'bool';
}
