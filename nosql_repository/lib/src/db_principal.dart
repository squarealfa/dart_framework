/// Represents a user that performs operations on a database.
abstract class DbPrincipal {
  /// identifies the user uniquely amongst all other users from the
  /// same tenant, which is identified in [tenantKey]
  String get userKey;

  /// Identifies the tenant to which the user belongs
  String get tenantKey;

  /// Returns a value indicating whether the user
  /// has a permission [permission].
  bool hasPermission(String permission);
}
