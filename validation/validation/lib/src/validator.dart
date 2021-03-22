import 'error_list.dart';

abstract class Validator {
  ErrorList validate(Object entity);
  void validateThrowing(Object entity);
}
