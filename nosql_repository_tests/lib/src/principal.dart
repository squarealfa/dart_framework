import 'package:nosql_repository/nosql_repository.dart';

class Principal extends DbPrincipal {
  final List<String> _permissions;
  final String _tenantKey;
  final String _userKey;

  Principal._(this._permissions, this._tenantKey, this._userKey);

  factory Principal(
    String username, [
    String? tenantKey,
  ]) {
    final permissions = _loadPermissions(username);
    final tkey = tenantKey ?? '607f866f98b65b55e497cee0';
    return Principal._(permissions, tkey, username);
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
      'search_recipes',
      if (username == 'root') 'change_settings',
    ];
  }
}
