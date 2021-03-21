import 'package:nosql_repository/nosql_repository.dart';

/// Defines authorization policy for
/// delete operations.
///
/// The purpose of this class is to
/// expose the method [actionToDemandOnPrincipal]
/// that determines the required shares, containing
/// which action, that each entity that is
/// to be deleted is required.
///
/// For example, if the method determines that
/// the action is 'write', then all delete operations
/// will only delete entities that have a share
/// with the 'write' action for the [principal]. If
/// the [actionToDemandOnPrincipal] returns an empty
/// string, then the delete actions are not limited
/// by the shares each entity has for the user.
///
/// This policy also determines whether deletions
/// are limited to the same tenant as the [principal]'s.
class DeletePolicy extends UpdatePolicy {
  const DeletePolicy({
    String permission = '',
    bool filterByTenant = true,
    String actionToDemand = 'write',
  }) : super(
          permission: permission,
          filterByTenant: filterByTenant,
          actionToDemand: actionToDemand,
        );
}
