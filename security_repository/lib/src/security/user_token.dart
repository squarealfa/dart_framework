class UserToken {
  final String token;
  final bool isAdministrator;
  final List<String> permissions;

  UserToken({
    required this.token,
    required this.isAdministrator,
    required this.permissions,
  });
}
