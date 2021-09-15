import 'package:nosql_repository/nosql_repository.dart';

class Principal implements DbPrincipal {
  static const _unauthenticated = Principal(
    userKey: '',
    tenantKey: '',
    permissions: {},
  );

  @override
  final String userKey;
  @override
  final String tenantKey;
  final Set<String> permissions;
  final bool isAuthenticated;

  const Principal({
    required this.userKey,
    required this.tenantKey,
    required this.permissions,
    this.isAuthenticated = false,
  });

  factory Principal.unauthenticated() => _unauthenticated;

  @override
  bool hasPermission(String permission) {
    if (permission == '') {
      return true;
    }
    var hasPermission = permissions.contains(permission);
    return hasPermission;
  }
}
