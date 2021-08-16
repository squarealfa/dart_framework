/// Defines the CRUD permissions for a PODO
abstract class EntityPermissions {
  const EntityPermissions();
  String get read;
  String get create;
  String get update;
  String get delete;
}
