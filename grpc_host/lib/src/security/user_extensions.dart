import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

extension UserExtensions on UserBase {
  Principal toPrincipal() {
    final principal = Principal(
      userKey: key,
      tenantKey: tenantKey,
      name: friendlyName,
      username: username,
      permissions: cache?.permissions ?? [],
      isAdministrator: cache?.isAdministrator ?? false,
      isAuthenticated: true,
    );
    return principal;
  }

  JwtPayload toJwtPayload({
    required String issuer,
    required String audience,
    required Duration timeToLive,
  }) {
    final payload = JwtPayload(
      name: friendlyName,
      username: username,
      subject: key,
      issuer: issuer,
      audience: audience,
      notBefore: DateTime.now().toUtc(),
      expires: DateTime.now().toUtc().add(timeToLive),
    );
    return payload;
  }
}
