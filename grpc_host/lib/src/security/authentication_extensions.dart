import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

import 'principal.dart';
import 'user_extensions.dart';

part 'service_call_extra.dart';

extension AuthenticationExtensions on ServiceCall {
  static final Expando _storage = Expando();

  Future<Principal> _createPrincipal<TUser extends UserBase<TUserCache>,
      TUserCache extends UserCacheBase>(
    String subject,
    UserRepositoryBase userRepository,
    MapMapper<TUser> mapMapper,
  ) async {
    final userMap = await userRepository.getFromUsername(subject);
    final user = mapMapper.fromMap(userMap);
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

  Future authenticate<TUser extends UserBase<TUserCache>,
      TUserCache extends UserCacheBase>(
    TokenServicesParameters tokenServicesParameters,
    UserRepositoryBase userRepository,
    MapMapper<TUser> mapMapper,
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
      if (payload.expires.difference(DateTime.now()).isNegative) {
        throw 'Expired token';
      }
      local_principal = await _createPrincipal(
        payload.subject,
        userRepository,
        mapMapper,
      );
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
