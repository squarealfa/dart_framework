import 'package:nosql_repository/nosql_repository.dart';

class Principal extends DbPrincipal {
  final List<String> _permissions;
  final String _tenantKey;
  final String _userKey;

  Principal._(this._permissions, this._tenantKey, this._userKey);

  factory Principal(String username) {
    var permissions = _loadPermissions(username);
    var tenantKey = _loadTenantKey(username);
    return Principal._(permissions, tenantKey, username);
  }

  @override
  bool hasPermission(String permission) {
    return _permissions.contains(permission);
  }

  @override
  String get tenantKey => _tenantKey;

  @override
  String get userKey => _userKey;

  static List<String> _loadPermissions(String username) {
    return [
      'login',
      'create_recipes',
      'read_recipes',
      'update_recipes',
      //'delete_recipes',
      'search_recipes',
      if (username == 'root') 'change_settings',
    ];
  }

  static String _loadTenantKey(String username) => 'single_tenant';
}
