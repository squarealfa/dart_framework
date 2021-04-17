import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoKeyHandler extends KeyHandler {
  @override
  String keyFromMap(
    Map<String, dynamic> map, [
    String fieldName = '',
  ]) {
    final mapKey = _fieldNameToMapKey(fieldName);
    if (map[mapKey] is ObjectId) {
      final ret = (map[mapKey] as ObjectId).toHexString();
      return ret;
    }
    return map[mapKey] ?? '';
  }

  @override
  void keyToMap(
    Map<String, dynamic> map,
    String value, [
    String fieldName = '',
  ]) {
    final mapKey = _fieldNameToMapKey(fieldName);

    if (value.isEmpty) {
      map.remove(mapKey);
    } else {
      map[mapKey] = ObjectId.fromHexString(value);
    }
  }

  String _fieldNameToMapKey(String fieldName) {
    switch (fieldName) {
      case '':
      case 'id':
      case 'key':
        return '_id';
      default:
        final ret = fieldName.endsWith('Key')
            ? '${fieldName.substring(0, fieldName.length - 3)}Id'
            : fieldName;
        return ret;
    }
  }
}
