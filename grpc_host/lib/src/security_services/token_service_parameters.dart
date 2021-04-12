import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

class TokenServicesParameters {
  final UserRepository userRepository;
  final JsonWebTokenHandler tokenHandler;
  final String tokenIssuer;
  final String tokenAudience;

  TokenServicesParameters({
    required this.userRepository,
    required this.tokenHandler,
    required this.tokenIssuer,
    required this.tokenAudience,
  });
}
