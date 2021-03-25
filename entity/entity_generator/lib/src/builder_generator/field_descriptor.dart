import 'package:analyzer/dart/element/element.dart';
import 'package:entity_adapter/entity_adapter.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

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

  bool get typeHasEntityMapAnnotation {
    var annotation = TypeChecker.fromRuntime(MapEntity)
        .firstAnnotationOf(fieldElement.type.element);
    return annotation != null;
  }

  bool get parameterTypeHasEntityMapAnnotation {
    var annotation = TypeChecker.fromRuntime(MapEntity)
        .firstAnnotationOf(parameterType.element);
    return annotation != null;
  }
}
