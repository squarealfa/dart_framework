// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserCopyWithExtension on User {
  User copyWith({
    String? key,
    Meta? meta,
    DateTime? creationDate,
    String? emailAddress,
    String? friendlyName,
    String? passwordHash,
    String? passwordSalt,
    bool? isLocked,
    int? numberOfFailedAttempts,
    List<String>? roles,
    UserCache? cache,
    bool setCacheToNull = false,
  }) {
    return User(
      key: key ?? this.key,
      meta: meta ?? this.meta,
      creationDate: creationDate ?? this.creationDate,
      emailAddress: emailAddress ?? this.emailAddress,
      friendlyName: friendlyName ?? this.friendlyName,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      isLocked: isLocked ?? this.isLocked,
      numberOfFailedAttempts:
          numberOfFailedAttempts ?? this.numberOfFailedAttempts,
      roles: roles ?? this.roles,
      cache: setCacheToNull ? null : cache ?? this.cache,
    );
  }
}

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class UserMapMapper extends MapMapper<User> {
  static final UserMapMapper _singleton = UserMapMapper._();

  UserMapMapper._();
  factory UserMapMapper() => _singleton;

  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      key: map['key'] as String,
      meta: MetaMapMapper().fromMap(map['meta']),
      creationDate: DateTime.parse(map['creationDate']),
      emailAddress: map['emailAddress'] as String,
      friendlyName: map['friendlyName'] as String,
      passwordHash: map['passwordHash'] as String,
      passwordSalt: map['passwordSalt'] as String,
      isLocked: map['isLocked'] as bool,
      numberOfFailedAttempts: map['numberOfFailedAttempts'] as int,
      roles: List<String>.from(map['roles']),
      cache: (map['cache'] != null
          ? UserCacheMapMapper().fromMap(map['cache'])
          : null),
    );
  }

  @override
  Map<String, dynamic> toMap(User instance) {
    final map = <String, dynamic>{};

    map['key'] = instance.key;
    map['meta'] = MetaMapMapper().toMap(instance.meta);
    map['creationDate'] = instance.creationDate.toIso8601String();
    map['emailAddress'] = instance.emailAddress;
    map['friendlyName'] = instance.friendlyName;
    map['passwordHash'] = instance.passwordHash;
    map['passwordSalt'] = instance.passwordSalt;
    map['isLocked'] = instance.isLocked;
    map['numberOfFailedAttempts'] = instance.numberOfFailedAttempts;
    map['roles'] = instance.roles;
    ;
    map['cache'] = (instance.cache == null
        ? null
        : UserCacheMapMapper().toMap(instance.cache!));

    return map;
  }
}

extension UserMapExtension on User {
  Map<String, dynamic> toMap() => UserMapMapper().toMap(this);
  static User fromMap(Map<String, dynamic> map) => UserMapMapper().fromMap(map);
}

extension MapUserExtension on Map<String, dynamic> {
  User toUser() => UserMapMapper().fromMap(this);
}
