import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

import 'principal.dart';
import 'user_extensions.dart';

part 'service_call_extra.dart';

extension AuthenticationExtensions on ServiceCall {
  static final Expando _storage = Expando();

  Future<Principal> _createPrincipal(
    JwtPayload payload,
    UserRepository userRepository,
  ) async {
    if (payload.expires.difference(DateTime.now()).isNegative) {
      throw 'Expired token';
    }
    final subject = payload.subject;
    final user = await userRepository.getFromUsername(subject);
    final principal = user.toPrincipal();
    return principal;
  }

  Principal get principal {
    return _extra.principal ?? Principal.unauthenticated();
  }

  JwtPayload? get jwtPayload => _extra.jwtPayload;

  _ServiceCallExtra get _extra {
    var ret = _storage[this] ??= _ServiceCallExtra();
    return ret as _ServiceCallExtra;
  }

  Future authenticate(
    TokenServicesParameters tokenServicesParameters,
    UserRepository userRepository,
  ) async {
    Principal? local_principal;
    try {
      var token = clientMetadata?['authorization'];
      if (token == null) {
        _extra.jwtPayload = null;
        _extra.principal = null;
        return;
      }
      var payload = tokenServicesParameters.tokenHandler.load(token);
      _extra.jwtPayload = payload;
      local_principal = await _createPrincipal(
        payload,
        userRepository,
      );
    } catch (e) {
      throw GrpcError.unauthenticated();
    } finally {
      _extra.principal = local_principal;
    }
    return;
  }
}
