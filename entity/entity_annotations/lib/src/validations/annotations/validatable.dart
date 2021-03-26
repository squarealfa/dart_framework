import 'validatable_base.dart';

/// Annotation that indicates that the class to
/// which it is applied to is a validatable class
///
/// A validatable class one for which the validation
/// code generator generates a [Validator] class.
///
///
class Validatable implements ValidatableBase {
  @override
  final bool createValidatableBaseClass;
  const Validatable({
    this.createValidatableBaseClass = false,
  });
}

const validatable = Validatable();
