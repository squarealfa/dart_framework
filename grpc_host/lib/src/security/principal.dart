import 'package:nosql_repository/nosql_repository.dart';

class Principal implements DbPrincipal {
  static const _unauthenticated = Principal(
    userKey: '',
    tenantKey: '',
    name: '',
    username: '',
    permissions: [],
    isAdministrator: false,
  );

  @override
  final String userKey;
  @override
  final String tenantKey;
  final String name;
  final String username;
  final List<String> permissions;
  final bool isAdministrator;
  final bool isAuthenticated;

  const Principal({
    required this.userKey,
    required this.tenantKey,
    required this.name,
    required this.username,
    required this.permissions,
    required this.isAdministrator,
    this.isAuthenticated = false,
  });

  factory Principal.unauthenticated() => _unauthenticated;

  @override
  bool hasPermission(String permission) {
    if (isAdministrator) {
      return true;
    }
    if (permission == '') {
      return true;
    }
    var hasPermission = permissions.contains(permission);
    return hasPermission;
  }
}
