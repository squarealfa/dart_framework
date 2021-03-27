import 'package:analyzer/dart/element/element.dart';
import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

class FieldDescriptor extends FieldDescriptorBase {
  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement,
  ) : super(classElement, fieldElement);

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
  ) {
    return FieldDescriptor._(
      classElement,
      fieldElement,
    );
  }

  bool get typeHasDefaultsProvider {
    var annotation = TypeChecker.fromRuntime(DefaultsProvider)
        .firstAnnotationOf(fieldElement.type.element!);
    return annotation != null;
  }
}
