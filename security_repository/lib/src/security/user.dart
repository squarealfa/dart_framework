import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

//import 'package:squarealfa_sec'

import 'meta.dart';
import 'user_cache.dart';

part 'user.g.dart';

@mapMap
@copyWith
class User {
  const User({
    this.key = '',
    required this.meta,
    required this.creationDate,
    required this.emailAddress,
    required this.friendlyName,
    this.passwordHash = '',
    this.passwordSalt = '',
    required this.isLocked,
    required this.numberOfFailedAttempts,
    required this.roles,
    this.cache,
  });

  final String key;
  final Meta meta;
  final DateTime creationDate;
  final String emailAddress;
  final String friendlyName;

  final String passwordHash;

  final String passwordSalt;

  final bool isLocked;

  final int numberOfFailedAttempts;

  final List<String> roles;

  final UserCache? cache;
}
