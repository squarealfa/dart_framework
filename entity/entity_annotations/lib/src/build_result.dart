import 'validations/error_list.dart';

class BuildResult<T> {
  final T? result;
  final ErrorList validationErrors;
  final Object? exception;

  BuildResult({
    this.result,
    this.validationErrors = const ErrorList([]),
    this.exception,
  });
}
