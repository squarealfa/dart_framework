import 'result.dart';

class DocumentResponse {
  final Result result;
  final Map<String, dynamic> document;

  const DocumentResponse({
    required this.result,
    required this.document,
  });
}
