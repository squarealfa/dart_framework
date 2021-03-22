import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:validation/validation.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'field_element_annotation_extension.dart';

class FieldDescriptor extends FieldDescriptorBase {
  final Required requiredAnnotation;

  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement, {
    this.requiredAnnotation,
  }) : super(classElement, fieldElement) {}

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
  ) {
    final requiredAnnotation = fieldElement.getRequiredAnnotation();

    return FieldDescriptor._(
      classElement,
      fieldElement,
      requiredAnnotation: requiredAnnotation,
    );
  }

  bool get hasRequired => requiredAnnotation != null;

  bool get typeIsValidatable {
    var annotation = TypeChecker.fromRuntime(ValidatableBase)
        .firstAnnotationOf(fieldElement.type.element);
    return annotation != null;
  }

  bool get parameterTypeIsValidatable {
    if (parameterType == null) return null;
    var annotation = TypeChecker.fromRuntime(ValidatableBase)
        .firstAnnotationOf(parameterType.element);
    return annotation != null;
  }
}
