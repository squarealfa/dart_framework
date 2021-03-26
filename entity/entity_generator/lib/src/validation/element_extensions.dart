// import 'package:analyzer/dart/element/element.dart';
// import 'package:source_gen/source_gen.dart';

// import 'field_descriptor.dart';

// // class _FieldSet implements Comparable<_FieldSet> {
// //   final FieldElement field;

// //   _FieldSet._(this.field);

// //   factory _FieldSet(FieldElement classField, FieldElement superField) {
// //     // At least one of these will != null, perhaps both.
// //     final fields = [classField, superField].where((fe) => fe != null).toList();

// //     // Prefer the class field over the inherited field when sorting.
// //     final sortField = fields.first;

// //     return _FieldSet._(sortField);
// //   }

// //   @override
// //   int compareTo(_FieldSet other) => _sortByLocation(field, other.field);

// //   static int _sortByLocation(FieldElement a, FieldElement b) {
// //     final checkerA = TypeChecker.fromStatic(
// //         // ignore: unnecessary_cast
// //         (a.enclosingElement as ClassElement).thisType);

// //     if (!checkerA.isExactly(b.enclosingElement)) {
// //       // in this case, you want to prioritize the enclosingElement that is more
// //       // "super".

// //       if (checkerA.isAssignableFrom(b.enclosingElement)) {
// //         return -1;
// //       }

// //       final checkerB = TypeChecker.fromStatic(
// // ignore: todo
// //           // TODO: remove `ignore` when min pkg:analyzer >= 0.38.0
// //           // ignore: unnecessary_cast
// //           (b.enclosingElement as ClassElement).thisType);

// //       if (checkerB.isAssignableFrom(a.enclosingElement)) {
// //         return 1;
// //       }
// //     }

// //     /// Returns the offset of given field/property in its source file – with a
// //     /// preference for the getter if it's defined.
// //     int _offsetFor(FieldElement e) {
// //       if (e.getter != null && e.getter.nameOffset != e.nameOffset) {
// //         assert(e.nameOffset == -1);
// //         return e.getter.nameOffset;
// //       }
// //       return e.nameOffset;
// //     }

// //     return _offsetFor(a).compareTo(_offsetFor(b));
// //   }
// // }

// extension ElementExtension on Element {
//   ClassElement asClassElement() {
//     var classElement = this as ClassElement;
//     if (classElement == null)
//       throw InvalidGenerationSourceError(
//         '`${name}` must be a class',
//         todo: 'Remove @Proto annotation from `${name}`',
//         element: this,
//       );
//     return classElement;
//   }
// }

// extension ClassElementFieldExtension on ClassElement {
//   Iterable<FieldElement> getSortedFieldSet() {
//     // Get all of the fields that need to be assigned
//     final elementInstanceFields =
//         this.fields.where((e) => !e.isStatic || e.isEnumConstant).toList();

//     return elementInstanceFields
//         .where((field) =>
//             (field.getter != null &&
//                 (field.setter != null ||
//                     field.isFinal &&
//                         field.getter.isSynthetic &&
//                         !this.isEnum)) ||
//             (field.getter == null && field.setter == null) ||
//             field.isEnumConstant)
//         .toList();
//   }

//   Iterable<FieldDescriptor> getFieldDescriptors() {
//     final fieldSet = this.getSortedFieldSet();
//     final fieldDescriptors = fieldSet
//         .map((fieldElement) => FieldDescriptor.fromFieldElement(
//               this,
//               fieldElement,
//             ))
//         .where((element) => element.isIncluded);
//     return fieldDescriptors;
//   }
// }
