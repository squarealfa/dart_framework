class UserPermissionSet {
  final Set<String> permissions;
  final bool isAdministrator;

  UserPermissionSet({
    required this.permissions,
    required this.isAdministrator,
  });
}
