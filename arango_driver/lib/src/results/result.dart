class Result {
  final bool error;
  final int code;
  final String? errorMessage;
  final int? errorNum;

  const Result({
    required this.error,
    required this.code,
    this.errorMessage,
    this.errorNum,
  });

  factory Result.empty() => Result(
        error: false,
        code: 0,
      );
}
