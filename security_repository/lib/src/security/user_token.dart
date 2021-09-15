import 'package:security_repository/src/security/user_base.dart';

class UserToken<TUser extends UserBase> {
  final UserBase user;
  final String token;
  final DateTime expires;

  UserToken({
    required this.user,
    required this.token,
    required this.expires,
  });
}
