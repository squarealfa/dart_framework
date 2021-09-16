import 'package:security_repository/src/security/user_permission_set.dart';

abstract class UserSecurityRepository {
  Future<Map<String, dynamic>> getFromUsername(String username);

  Future<Map<String, dynamic>> updateUser(
    String key,
    Map<String, dynamic> userMap,
  );
  Future<UserPermissionSet> getUserPermissionSet(String key);
}
