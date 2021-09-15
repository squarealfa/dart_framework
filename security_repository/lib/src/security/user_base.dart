//import 'package:squarealfa_sec'

class UserBase {
  const UserBase({
    this.key = '',
    required this.username,
    required this.tenantKey,
    required this.friendlyName,
    required this.roles,
    required this.isAdministrator,
    required this.isLocked,
    required this.numberOfFailedAttempts,
  });

  final String tenantKey;
  final String key;
  final String username;

  final String friendlyName;

  final Iterable<String> roles;
  final bool isAdministrator;
  final bool isLocked;
  final int numberOfFailedAttempts;
}
