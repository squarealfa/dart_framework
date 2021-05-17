import 'package:security_repository/security_repository.dart';

abstract class UserRepositoryBase {
  Future<Map<String, dynamic>> getFromUsername(String username);
  Future<Map<String, dynamic>> getFromKey(String key);

  Future<Map<String, dynamic>> updateUser(
    String key,
    Map<String, dynamic> userMap,
  );
  Future<UserPermissionSet> getUserPermissionSet(String key);
}
