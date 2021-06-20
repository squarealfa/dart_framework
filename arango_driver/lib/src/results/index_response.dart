import 'index_info.dart';
import 'result.dart';

class IndexResponse {
  final IndexInfo indexInfo;
  final Result result;

  const IndexResponse({
    required this.result,
    required this.indexInfo,
  });
}
