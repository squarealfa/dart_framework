import 'collection_info.dart';
import 'collection_response.dart';
import 'key_options.dart';
import 'result.dart';

class CollectionPropertiesResponse extends CollectionResponse {
  final int writeConcern;
  final bool waitForSync;
  final String tempObjectId;
  final bool cacheEnabled;
  final bool isSmartChild;
  final String objectId;
  final String? schema;
  final KeyOptions keyOptions;
  final bool isDisjoint;
  final String statusString;

  const CollectionPropertiesResponse({
    required Result result,
    required CollectionInfo collectionInfo,
    required this.writeConcern,
    required this.waitForSync,
    required this.tempObjectId,
    required this.cacheEnabled,
    required this.isSmartChild,
    required this.objectId,
    this.schema,
    required this.keyOptions,
    required this.isDisjoint,
    required this.statusString,
  }) : super(
          result: result,
          collectionInfo: collectionInfo,
        );
}
