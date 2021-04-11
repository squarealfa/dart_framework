import 'jwt_exception.dart';

/// Represents an invalid signature error.
///
/// This error signifies that a JWT token
/// may be correct on every other aspect, but
/// its signature isn't compatible with its
/// contents and the key.
class InvalidSignatureException extends JwtException {}
