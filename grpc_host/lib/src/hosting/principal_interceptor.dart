import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class PrincipalInterceptor {
  /// Loads a JWT and validates it returning the payload.
  Future<JwtPayload> getTokenPayload(String idToken);

  /// Creates a principal that contains user identity and authorization
  /// from a JWT payload.
  Future<Principal> createPrincipal(JwtPayload payload);

  FutureOr<GrpcError?> interceptor(
    ServiceCall call,
    ServiceMethod method,
  ) async {
    await call.authenticate(
      getTokenPayload: getTokenPayload,
      createPrincipal: createPrincipal,
    );
  }
}
