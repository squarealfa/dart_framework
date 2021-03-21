import 'package:nosql_repository/nosql_repository.dart';

/// Defines a policy to determine if a user has
/// the authorization to perform an operation on an entity.
///
/// Refer to the subclasses like [SearchPolicy] for
/// an easier and better understanding of the concept
/// presented by this abstract class.
abstract class PermissionPolicy {
  /// the permission that will allow the user to
  /// perform the operation on an entity.
  final String permission;

  /// whether to allow the user to perform the
  /// action on entities other than those strictly
  /// belonging to the same tenant.
  final bool filterByTenant;

  const PermissionPolicy(
    this.permission,
    this.filterByTenant,
  );
}
