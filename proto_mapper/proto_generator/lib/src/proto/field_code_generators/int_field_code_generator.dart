import '../field_code_generator.dart';
import '../field_descriptor.dart';

class IntFieldCodeGenerator extends FieldCodeGenerator {
  IntFieldCodeGenerator(FieldDescriptor fieldDescriptor, int lineNumber)
      : super(fieldDescriptor, lineNumber);

  @override
  String get fieldType => 'int32';
}
