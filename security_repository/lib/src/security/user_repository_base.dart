import 'package:security_repository/src/security/user_base.dart';

abstract class UserRepositoryBase<TUser extends UserBase> {
  Future<TUser> getFromUsername(String username);
  Future<TUser> getFromKey(String key);
  Future<TUser> updateUserCache(TUser user);
}
