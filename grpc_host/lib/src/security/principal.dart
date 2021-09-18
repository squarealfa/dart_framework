import 'package:grpc/grpc.dart';
import 'package:nosql_repository/nosql_repository.dart';

class Principal implements DbPrincipal {
  @override
  final String userKey;
  @override
  final String tenantKey;
  final Set<String> permissions;
  final bool isAuthenticated;
  final bool isAdministrator;

  const Principal({
    required this.userKey,
    required this.tenantKey,
    required this.permissions,
    required this.isAdministrator,
    this.isAuthenticated = false,
  });

  const Principal.unauthenticated()
      : userKey = '',
        tenantKey = '',
        isAuthenticated = false,
        isAdministrator = false,
        permissions = const {};

  @override
  bool hasPermission(String permission) {
    if (isAdministrator || permission == '') {
      return true;
    }
    var hasPermission = permissions.contains(permission);
    return hasPermission;
  }

  void throwIfUnauthenticated() {
    if (!isAuthenticated) {
      throw GrpcError.unauthenticated();
    }
  }
}
