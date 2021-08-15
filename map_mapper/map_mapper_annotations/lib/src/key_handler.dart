import 'default_key_handler.dart';

abstract class KeyHandler {
  static KeyHandler defaultKeyHandler = DefaultKeyHandler();

  KeyHandler();

  factory KeyHandler.fromDefault() => defaultKeyHandler;

  void keyToMap(
    Map<String, dynamic> map,
    String value, [
    String fieldName = '',
  ]);
  String keyFromMap(
    Map<String, dynamic> map, [
    String fieldName = '',
  ]);

  String fieldNameToMapKey(String fieldName);
}
