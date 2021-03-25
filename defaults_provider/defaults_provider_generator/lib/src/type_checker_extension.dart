import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

extension TypeCheckerExtension on TypeChecker {
  DartObject? getFieldAnnotation(FieldElement fieldElement) =>
      firstAnnotationOf(fieldElement) ??
      (fieldElement.getter == null
          ? null
          : firstAnnotationOf(fieldElement.getter!));

  DartObject? getClassAnnotation(ClassElement classElement) =>
      firstAnnotationOf(classElement);
}
