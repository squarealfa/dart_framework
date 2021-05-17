//import 'package:squarealfa_sec'

import 'user_cache_base.dart';

class UserBase<TUserCache extends UserCacheBase> {
  const UserBase({
    this.key = '',
    required this.username,
    required this.tenantKey,
    required this.friendlyName,
    required this.roles,
    required this.isLocked,
    required this.numberOfFailedAttempts,
    this.cache,
  });

  final String tenantKey;
  final String key;
  final String username;

  final String friendlyName;

  final List<String> roles;
  final bool isLocked;
  final int numberOfFailedAttempts;

  final TUserCache? cache;
}
