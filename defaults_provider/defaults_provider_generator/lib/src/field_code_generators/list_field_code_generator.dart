import '../field_code_generator.dart';
import '../field_descriptor.dart';

class ListFieldCodeGenerator extends FieldCodeGenerator {
  ListFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor) {}

  @override
  get defaultExpression => '[]';
}
