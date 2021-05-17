abstract class UserCacheBase {
  final DateTime updateTimestamp;
  final List<String> permissions;
  final bool isAdministrator;

  UserCacheBase({
    required this.updateTimestamp,
    required this.permissions,
    required this.isAdministrator,
  });

  @override
  bool operator ==(Object other) {
    if (other is! UserCacheBase) return false;
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
