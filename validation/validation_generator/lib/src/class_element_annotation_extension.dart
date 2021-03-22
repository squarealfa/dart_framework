// import 'package:analyzer/dart/element/element.dart';
// import 'package:source_gen/source_gen.dart';
// import 'package:validation/validation.dart';
// import 'type_checker_extension.dart';

// extension ClassElementAnnotationExtension on ClassElement {
//   static const _validatableChecker = TypeChecker.fromRuntime(Validatable);

//   Validatable getValidatableAnnotation() {
//     var annotation = _validatableChecker.getClassAnnotation(this);
//     if (annotation == null) return null;

//     var ret = Validatable(
//       createBaseClass:
//           annotation.getField('createBaseClass')?.toBoolValue() ?? false,
//     );
//     return ret;
//   }
// }
