part of 'proto_mapper_generator_base.dart';

Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, MapProtoBase annotation) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return fieldDescriptors;
}
