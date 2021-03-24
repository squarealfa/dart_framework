import '../field_code_generator.dart';
import '../field_descriptor.dart';

class StringFieldCodeGenerator extends FieldCodeGenerator {
  StringFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  @override
  get defaultExpression => '\'\'';
}
