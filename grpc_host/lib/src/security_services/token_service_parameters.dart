import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

class TokenServicesParameters<TUser extends UserBase> {
  final UserRepositoryBase userRepository;
  final JsonWebTokenHandler tokenHandler;
  final String tokenIssuer;
  final String tokenAudience;
  final Duration tokenTimeToLive;

  TokenServicesParameters({
    required this.userRepository,
    required this.tokenHandler,
    required this.tokenIssuer,
    required this.tokenAudience,
    required this.tokenTimeToLive,
  });
}
