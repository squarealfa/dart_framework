import 'package:nosql_repository/nosql_repository.dart';

/// Defines a policy to determine if a user has
/// the authorization to perform an operation on an entity.
///
/// Refer to the subclasses like [SearchPolicy] for
/// an easier and better understanding of the concept
/// presented by this abstract class.
abstract class EntityPermissionPolicy extends PermissionPolicy {
  const EntityPermissionPolicy(
    String permission,
    bool filterByTenant,
  ) : super(permission, filterByTenant);

  /// determines which share with which action
  /// the user must have on the entity in order
  /// to be able to permform the operation on the entity.
  String actionToDemandOnPrincipal(DbPrincipal principal);
}
