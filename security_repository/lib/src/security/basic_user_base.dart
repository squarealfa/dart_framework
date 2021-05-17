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
    TUserCache? cache,
    this.passwordHash = '',
    this.passwordSalt = '',
  }) : super(
            key: key,
            username: username,
            tenantKey: tenantKey,
            friendlyName: friendlyName,
            roles: roles,
            cache: cache);
  final String passwordHash;
  final String passwordSalt;
}
