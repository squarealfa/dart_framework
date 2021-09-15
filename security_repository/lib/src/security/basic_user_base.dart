import 'user_base.dart';

class BasicUserBase
    extends UserBase {
  BasicUserBase({
    String key = '',
    required String username,
    required String tenantKey,
    required String friendlyName,
    required Iterable<String> roles,
    required bool isAdministrator,
    required bool isLocked,
    required int numberOfFailedAttempts,
    this.passwordHash = '',
    this.passwordSalt = '',
  }) : super(
          key: key,
          username: username,
          tenantKey: tenantKey,
          friendlyName: friendlyName,
          roles: roles,
          isAdministrator: isAdministrator,
          isLocked: isLocked,
          numberOfFailedAttempts: numberOfFailedAttempts,
        );
  final String passwordHash;
  final String passwordSalt;
}
