import 'package:security_repository/src/security/user.dart';

abstract class UserRepository {
  Future<User> getFromUsername(String username);
  Future<User> getFromKey(String key);
  Future<User> updateUserCache(User user);
}
