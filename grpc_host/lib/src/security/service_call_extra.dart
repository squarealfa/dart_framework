part of 'authentication_extensions.dart';

class _ServiceCallExtra {
  Principal? principal;
  JwtPayload? jwtPayload;

  _ServiceCallExtra({
    this.principal,
    this.jwtPayload,
  });
}
