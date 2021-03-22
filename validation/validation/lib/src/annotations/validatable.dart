import 'validatable_base.dart';

class Validatable implements ValidatableBase {
  @override
  final bool createValidatableBaseClass;
  const Validatable({
    this.createValidatableBaseClass = false,
  });
}

const validatable = Validatable();
