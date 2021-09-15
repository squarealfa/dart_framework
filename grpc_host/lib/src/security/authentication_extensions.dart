import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

import 'principal.dart';

part 'service_call_extra.dart';

extension AuthenticationExtensions on ServiceCall {
  static final Expando _storage = Expando();

  Principal get principal {
    return _extra.principal ?? Principal.unauthenticated();
  }

  JwtPayload? get jwtPayload => _extra.jwtPayload;

  _ServiceCallExtra get _extra {
    var ret = _storage[this] ??= _ServiceCallExtra();
    return ret as _ServiceCallExtra;
  }

  Future authenticate<TUser extends UserBase>({
    required JwtPayload Function(String token) getTokenPayload,
    required Future<Principal> Function(JwtPayload payload) createPrincipal,
  }) async {
    Principal? local_principal;
    try {
      var token = clientMetadata?['authorization'];
      if (token == null) {
        _extra.jwtPayload = null;
        _extra.principal = null;
        return;
      }

      var payload = getTokenPayload(token);
      if (payload.expires.difference(DateTime.now()).isNegative) {
        throw 'Expired token';
      }

      _extra.jwtPayload = payload;
      local_principal = await createPrincipal(payload);
    } catch (e) {
      throw GrpcError.unauthenticated();
    } finally {
      _extra.principal = local_principal;
    }
    return;
  }
}

void authenticateCalls(ServiceCall context) {
  var principal = context.principal;
  if (!principal.isAuthenticated) {
    throw GrpcError.unauthenticated();
  }
}
