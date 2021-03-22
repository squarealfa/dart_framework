import 'error_list.dart';
import 'validation_error.dart';

class PropertyValidation extends ValidationError {
  final ErrorList errorList;

  const PropertyValidation(String fieldName, this.errorList) : super(fieldName);
}
