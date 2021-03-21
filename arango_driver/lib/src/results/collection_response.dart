import 'collection_info.dart';
import 'result.dart';

class CollectionResponse {
  final CollectionInfo collectionInfo;
  final Result result;

  const CollectionResponse({
    required this.result,
    required this.collectionInfo,
  });
}
