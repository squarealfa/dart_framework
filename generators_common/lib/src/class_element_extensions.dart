import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart'
    show InheritanceManager3;
import 'package:source_gen/source_gen.dart';

part 'fieldset.dart';
part 'methodset.dart';

const _dartCoreObjectChecker = TypeChecker.fromRuntime(Object);

/// Adds field and method retrieval features to the [ClassElement] class
extension ClassElementFieldExtension on ClassElement {
  /// Gets the public methods of the class
  ///
  /// This method will retrieve the methods of the
  /// super classes when the [includeInherited] parameter is true.
  ///
  /// It will retrieve non-static methods.
  Iterable<MethodElement> getSortedMethods({bool includeInherited = true}) {
    // Get all of the fields that need to be assigned
    final elementInstanceMethods = Map.fromEntries(
        this.methods.where((e) => !e.isStatic).map((e) => MapEntry(e.name, e)));

    final inheritedMethods = <String, MethodElement>{};
    final manager = InheritanceManager3();

    if (includeInherited) {
      for (final v in manager.getInheritedMap2(this).values) {
        assert(v is! FieldElement);
        if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
          continue;
        }

        if (v is MethodElement && !v.isStatic && !v.isPrivate) {
          // assert(v.variable is MethodElement);
          // final variable = v.variable as MethodElement;
          // assert(!inheritedMethods.containsKey(variable.name));
          inheritedMethods[v.name] = v;
        }
      }
    }

    // Get the list of all fields for `element`
    final allMethods = elementInstanceMethods.keys
        .toSet()
        .union(inheritedMethods.keys.toSet());

    final methods = allMethods
        .map((e) => _MethodSet(elementInstanceMethods[e], inheritedMethods[e]))
        .toList()
          ..sort();

    return methods.map((fs) => fs.method).toList();
  }

  /// Gets the public instance fields of the class
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
        .toList()
          ..sort();

    return fields
        .map((fs) => fs.field)
        .where((field) =>
            (field.getter != null &&
                (field.setter != null ||
                    field.isFinal && field.getter!.isSynthetic && !isEnum)) ||
            (field.getter == null && field.setter == null) ||
            field.isEnumConstant)
        .toList();
  }
}
