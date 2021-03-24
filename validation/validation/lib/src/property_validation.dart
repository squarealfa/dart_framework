import 'error_list.dart';
import 'errors/validation_error.dart';

/// Represents a [ValidationError] specific to a property that can contain
/// multiple errors
class PropertyValidation extends ValidationError {
  final ErrorList errorList;

  const PropertyValidation(String propertyName, this.errorList)
      : super(propertyName);
}
