import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

import '../field_code_generator.dart';
import '../field_descriptor.dart';

class GenericFieldCodeGenerator extends FieldCodeGenerator {
  GenericFieldCodeGenerator(
    FieldDescriptor fieldDescriptor,
    BuildBuilder buildBuilder,
  ) : super(fieldDescriptor, buildBuilder);
}
