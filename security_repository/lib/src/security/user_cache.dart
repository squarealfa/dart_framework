import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'user_cache.g.dart';

@mapMap
@copyWith
class UserCache {
  final DateTime updateTimestamp;
  final List<String> permissions;
  final bool isAdministrator;

  UserCache({
    required this.updateTimestamp,
    required this.permissions,
    required this.isAdministrator,
  });

  @override
  bool operator ==(Object other) {
    if (other is! UserCache) return false;
    final otherCache = other;
    if (otherCache.isAdministrator != isAdministrator) {
      return false;
    }

    if (otherCache.permissions.length != permissions.length) {
      return false;
    }

    for (var permission in permissions) {
      if (!otherCache.permissions.any((p) => p == permission)) return false;
    }
    for (var permission in otherCache.permissions) {
      if (!permissions.any((p) => p == permission)) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final prime = 31;
    var result = 1;
    result = prime * result + isAdministrator.hashCode;
    for (var permission in permissions) {
      result = prime * result + permission.hashCode;
    }
    return result;
  }
}
