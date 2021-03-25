import '../field_code_generator.dart';
import '../field_descriptor.dart';

class EnumFieldCodeGenerator extends FieldCodeGenerator {
  EnumFieldCodeGenerator(FieldDescriptor fieldDescriptor, bool isAbstract)
      : super(fieldDescriptor, isAbstract);
}
