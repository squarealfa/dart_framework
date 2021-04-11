import 'jwt_exception.dart';

/// Represents an invalid JWT token
class InvalidTokenException extends JwtException {
  final String? reason;

  InvalidTokenException({this.reason});
}
