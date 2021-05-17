import 'user_base.dart';
import 'user_cache_base.dart';

class BasicUserBase<TUserCache extends UserCacheBase>
    extends UserBase<TUserCache> {
  BasicUserBase({
    String key = '',
    required String username,
    required String tenantKey,
    required String friendlyName,
    required List<String> roles,
    required bool isLocked,
    required int numberOfFailedAttempts,
    TUserCache? cache,
    this.passwordHash = '',
    this.passwordSalt = '',
  }) : super(
          key: key,
          username: username,
          tenantKey: tenantKey,
          friendlyName: friendlyName,
          roles: roles,
          cache: cache,
          isLocked: isLocked,
          numberOfFailedAttempts: numberOfFailedAttempts,
        );
  final String passwordHash;
  final String passwordSalt;
}
