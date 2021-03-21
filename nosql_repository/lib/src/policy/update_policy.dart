import 'package:nosql_repository/nosql_repository.dart';

/// Defines authorization policy for
/// update operations.
///
/// The purpose of this class is to
/// expose the method [actionToDemandOnPrincipal]
/// that determines the required shares, containing
/// which action, that each entity that is
/// to be updated is required.
///
/// For example, if the method determines that
/// the action is 'write', then all update operations
/// will only update entities that have a share
/// with the 'write' action for the [principal]. If
/// the [actionToDemandOnPrincipal] returns an empty
/// string, then the update actions are not limited
/// by the shares each entity has for the user.
///
/// This policy also determines whether updates
/// are limited to the same tenant as the [principal]'s.
class UpdatePolicy extends EntityPermissionPolicy {
  /// Which action is to be demanded from the
  /// user when the user does not have a permission
  /// to update any entity.
  final String actionToDemand;
  const UpdatePolicy({
    String permission = '',
    bool filterByTenant = true,
    this.actionToDemand = 'write',
  }) : super(permission, filterByTenant);

  /// Determines the action that shares the entity has
  /// for the user.
  ///
  /// This method will return an empty string, meaning
  /// no share is required, in case the user has the
  /// [permission]. Otherwise, it will return [actionToDemand].
  @override
  String actionToDemandOnPrincipal(DbPrincipal principal) {
    return permission != '' && principal.hasPermission(permission)
        ? ''
        : actionToDemand;
  }
}
