import 'key_handler.dart';

class DefaultKeyHandler extends KeyHandler {
  @override
  String keyFromMap(Map<String, dynamic> map, [String fieldName = '']) {
    final mapKey = _fieldNameToMapKey(fieldName);
    return map[mapKey] ?? '';
  }

  @override
  void keyToMap(Map<String, dynamic> map, String value,
      [String fieldName = '']) {
    final mapKey = _fieldNameToMapKey(fieldName);

    if (value.isEmpty) {
      map.remove(mapKey);
    } else {
      map[mapKey] = value;
    }
  }

  String _fieldNameToMapKey(String fieldName) {
    switch (fieldName) {
      case '':
      case 'key':
        return '_key';
      default:
        return fieldName;
    }
  }
}
