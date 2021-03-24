import 'package:analyzer/dart/element/element.dart';
import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

class FieldDescriptor extends FieldDescriptorBase {
  //final Required requiredAnnotation;

  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement,
    // {
    //   this.requiredAnnotation,
    // }
  ) : super(classElement, fieldElement) {}

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
  ) {
//    final requiredAnnotation = fieldElement.getRequiredAnnotation();

    return FieldDescriptor._(
      classElement,
      fieldElement,
//      requiredAnnotation: requiredAnnotation,
    );
  }

  //bool get hasRequired => requiredAnnotation != null;

  bool get typeHasDefaultsProvider {
    var annotation = TypeChecker.fromRuntime(DefaultsProviderBase)
        .firstAnnotationOf(fieldElement.type.element);
    return annotation != null;
  }
}
