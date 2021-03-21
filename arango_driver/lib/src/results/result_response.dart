import 'result.dart';

class ResultResponse<T> {
  final T? response;
  final Result result;

  const ResultResponse({
    required this.result,
    this.response,
  });
}
