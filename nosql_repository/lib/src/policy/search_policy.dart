import 'package:nosql_repository/nosql_repository.dart';

/// Defines authorization policy for
/// search operations.
///
/// The purpose of this class is to
/// expose the method [actionToDemandOnPrincipal]
/// that determines the required shares, containing
/// which action, that each entity that is
/// returned by a search operation is required
/// to have for that entity to be returned to the
/// user.
///
/// For example, if the method determines that
/// the action is 'read', then all search operations
/// will only return entities that have a share
/// with the 'read' action for the [principal]. If
/// the [actionToDemandOnPrincipal] returns an empty
/// string, then the search results are not limited
/// by the shares each entity has for the user.
///
/// This policy also determines whether results
/// are limited to the same tenant as the [principal]'s.
class SearchPolicy extends EntityPermissionPolicy {
  /// Which action is to be demanded from the
  /// user when the user does not have a permission
  /// to search for all entities.
  final String actionToDemand;

  const SearchPolicy({
    String permission = '',
    bool filterByTenant = true,
    this.actionToDemand = 'read',
  }) : super(
          permission,
          filterByTenant,
        );

  const SearchPolicy.root()
      : this(
          permission: '',
          filterByTenant: false,
          actionToDemand: '',
        );

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
