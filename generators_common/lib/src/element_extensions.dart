import 'package:analyzer/dart/element/element.dart';

/// Simple downcast from [Element] to [ClassElement] as
/// an extension on [Element]
extension ElementExtension on Element {
  /// Returns this element as a [ClassElement]
  ClassElement asClassElement() {
    var classElement = this as ClassElement;
    return classElement;
  }
}
