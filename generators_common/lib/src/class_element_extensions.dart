import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart'
    show InheritanceManager3;
import 'package:source_gen/source_gen.dart';

part 'fieldset.dart';

const _dartCoreObjectChecker = TypeChecker.fromRuntime(Object);

/// Adds field retrieval features to the [ClassElement] class
extension ClassElementFieldExtension on ClassElement {
  /// Gets the public fields of the class
  ///
  /// This method will retrieve the fields of the
  /// super classes when the [includeInherited] parameter is true.
  ///
  /// It will retrieve enum fields and non-static fields.
  Iterable<MethodElement> getSortedMethods({bool includeInherited = true}) {
    // Get all of the fields that need to be assigned
    final elementInstanceFields = Map.fromEntries(
        methods.where((e) => !e.isStatic).map((e) => MapEntry(e.name, e)));

    final inheritedFields = <String, FieldElement>{};
    final manager = InheritanceManager3();

    if (includeInherited) {
      for (final v in manager.getInheritedMap2(this).values) {
        assert(v is! FieldElement);
        if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
          continue;
        }

        if (v is PropertyAccessorElement && v.isGetter) {
          assert(v.variable is FieldElement);
          final variable = v.variable as FieldElement;
          assert(!inheritedFields.containsKey(variable.name));
          inheritedFields[variable.name] = variable;
        }
      }
    }

    throw UnimplementedError();

    // Get the list of all fields for `element`
    // final allFields =
    //     elementInstanceFields.keys.toSet()
    // .union(inheritedFields.keys.toSet());

    // final fields = allFields
    //     .map((e) => _FieldSet(elementInstanceFields[e], inheritedFields[e]))
    //     .toList()
    //       ..sort();

    // return fields
    //     .map((fs) => fs.field)
    //     .where((field) =>
    //         (field!.getter != null &&
    //             (field.setter != null ||
    //                 field.isFinal && field.getter!
    // .isSynthetic && !isEnum)) ||
    //         (field.getter == null && field.setter == null) ||
    //         field.isEnumConstant)
    //     .toList();
  }

  /// Gets the public fields of the class
  ///
  /// This method will retrieve the fields of the
  /// super classes when the [includeInherited] parameter is true.
  ///
  /// It will retrieve enum fields and non-static fields.
  Iterable<FieldElement> getSortedFieldSet({bool includeInherited = true}) {
    // Get all of the fields that need to be assigned
    final elementInstanceFields = Map.fromEntries(this
        .fields
        .where((e) => !e.isStatic || e.isEnumConstant)
        .where((e) => !e.isPrivate)
        .map((e) => MapEntry(e.name, e)));

    final inheritedFields = <String, FieldElement>{};
    final manager = InheritanceManager3();

    if (includeInherited) {
      for (final v in manager.getInheritedMap2(this).values) {
        assert(v is! FieldElement);
        if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
          continue;
        }

        if (v is PropertyAccessorElement && v.isGetter && !v.isPrivate) {
          assert(v.variable is FieldElement);
          final variable = v.variable as FieldElement;
          assert(!inheritedFields.containsKey(variable.name));
          inheritedFields[variable.name] = variable;
        }
      }
    }

    // Get the list of all fields for `element`
    final allFields =
        elementInstanceFields.keys.toSet().union(inheritedFields.keys.toSet());

    final fields = allFields
        .map((e) => _FieldSet(elementInstanceFields[e], inheritedFields[e]))
        .where((e) => e.field != null)
        .toList()
          ..sort();

    return fields
        .map((fs) => fs.field!)
        .where((field) =>
            (field.getter != null &&
                (field.setter != null ||
                    field.isFinal && field.getter!.isSynthetic && !isEnum)) ||
            (field.getter == null && field.setter == null) ||
            field.isEnumConstant)
        .toList();
  }
}
