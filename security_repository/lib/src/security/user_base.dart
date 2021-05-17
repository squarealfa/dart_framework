//import 'package:squarealfa_sec'

import 'user_cache_base.dart';

class UserBase<TUserCache extends UserCacheBase> {
  const UserBase({
    this.key = '',
    required this.username,
    required this.tenantKey,
    required this.friendlyName,
    // this.passwordHash = '',
    // this.passwordSalt = '',
    required this.roles,
    this.cache,
  });

  final String tenantKey;
  final String key;
  final String username;

  final String friendlyName;

  // final String passwordHash;

  // final String passwordSalt;

  final List<String> roles;

  final TUserCache? cache;
}
