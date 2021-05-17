import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class UserTokenServices<TUser extends UserBase> {
  final TokenServicesParameters<TUser> parameters;
  final ServiceCall call;

  UserTokenServices(
    this.parameters,
    this.call,
  );

  UserRepositoryBase<TUser> get _userRepository => parameters.userRepository;
  JsonWebTokenHandler get _tokenHandler => parameters.tokenHandler;

  Future<UserToken> create(String username,
      Future<bool> Function(TUser user) isUserAuthenticated) async {
    TUser user;
    try {
      user = await _userRepository.getFromUsername(username);
    } on NotFound {
      throw GrpcError.notFound('User is not found');
    }

    final isAuthenticted = await isUserAuthenticated(user);
    if (!isAuthenticted) {
      throw GrpcError.unauthenticated('username or password is invalid');
    }

    user = await _userRepository.updateUserCache(user);

    var payload = user.toJwtPayload(
      issuer: parameters.tokenIssuer,
      audience: parameters.tokenAudience,
    );
    final token = _generateToken(payload, user);
    return token;
  }

  Future<UserToken> renew() async {
    final payload = call.jwtPayload;
    if (payload == null) {
      throw Unauthenticated();
    }

    TUser user;
    try {
      user = await _userRepository.getFromUsername(call.principal.username);
    } on NotFound {
      throw GrpcError.notFound('User is not found');
    }
    user = await _userRepository.updateUserCache(user);

    final newPayload = payload.CopyWith(
      notBefore: DateTime.now(),
      expires: DateTime.now().add(Duration(seconds: 300)),
    );
    final token = _generateToken(newPayload, user);
    return token;
  }

  UserToken _generateToken(JwtPayload payload, TUser user) {
    final token = _tokenHandler.generate(payload);
    final permissions = user.cache?.permissions ?? [];
    final isAdministrator = user.cache?.isAdministrator ?? false;

    var ret = UserToken(
      isAdministrator: isAdministrator,
      token: token,
      permissions: permissions,
    );
    return ret;
  }
}
