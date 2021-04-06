part of 'proto_mapper_generator.dart';

Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, MapProto annotation) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return fieldDescriptors;
}
