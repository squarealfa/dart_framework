part of 'class_element_extensions.dart';

class _MethodSet implements Comparable<_MethodSet> {
  final MethodElement method;

  _MethodSet._(this.method);

  factory _MethodSet(MethodElement? classMethod, MethodElement? superMethod) {
    // At least one of these will != null, perhaps both.
    final methods =
        [classMethod, superMethod].where((fe) => fe != null).toList();

    // Prefer the class field over the inherited field when sorting.
    final sortMethod = methods.first!;

    return _MethodSet._(sortMethod);
  }

  @override
  int compareTo(_MethodSet other) => _sortByLocation(method, other.method);

  static int _sortByLocation(MethodElement a, MethodElement b) {
    final checkerA = TypeChecker.fromStatic(
        // ignore: unnecessary_cast
        (a.enclosingElement as ClassElement).thisType);

    if (!checkerA.isExactly(b.enclosingElement)) {
      // in this case, you want to prioritize the enclosingElement that is more
      // "super".

      if (checkerA.isAssignableFrom(b.enclosingElement)) {
        return -1;
      }

      final checkerB =
          TypeChecker.fromStatic((b.enclosingElement as ClassElement).thisType);

      if (checkerB.isAssignableFrom(a.enclosingElement)) {
        return 1;
      }
    }

    return a.nameOffset.compareTo(b.nameOffset);
  }
}
