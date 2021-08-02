abstract class UserCacheBase {
  final DateTime updateTimestamp;
  final List<String> permissions;
  final bool isAdministrator;

  UserCacheBase({
    required this.updateTimestamp,
    required this.permissions,
    required this.isAdministrator,
  });

}
