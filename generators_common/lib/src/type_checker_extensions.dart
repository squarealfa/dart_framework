import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// Extension on the [TypeChecker] class to retrieve
/// the first annotation on the [fieldElement]
extension TypeCheckerExtensions on TypeChecker {
  DartObject? getFieldAnnotation(FieldElement fieldElement) =>
      firstAnnotationOf(fieldElement) ??
      (fieldElement.getter == null
          ? null
          : firstAnnotationOf(fieldElement.getter!));
}
