import 'package:security_repository/src/security/user_base.dart';

import 'user_cache_base.dart';

class UserToken<TUser extends UserBase<TUserCache>,
    TUserCache extends UserCacheBase> {
  final UserBase user;
  final String token;
  final bool isAdministrator;
  final List<String> permissions;
  final DateTime expires;

  UserToken({
    required this.user,
    required this.token,
    required this.isAdministrator,
    required this.permissions,
    required this.expires,
  });
}
