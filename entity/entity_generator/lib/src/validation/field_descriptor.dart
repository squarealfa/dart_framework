import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

class FieldDescriptor extends FieldDescriptorBase {
  FieldDescriptor._(ClassElement classElement, FieldElement fieldElement)
      : super(classElement, fieldElement);

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
  ) {
    return FieldDescriptor._(
      classElement,
      fieldElement,
    );
  }

  bool get typeIsValidatable {
    var annotation = TypeChecker.fromRuntime(ValidatableBase)
        .firstAnnotationOf(fieldElement.type.element!);
    return annotation != null;
  }

  bool get parameterTypeIsValidatable {
    var annotation = TypeChecker.fromRuntime(ValidatableBase)
        .firstAnnotationOf(parameterType.element!);
    return annotation != null;
  }
}
