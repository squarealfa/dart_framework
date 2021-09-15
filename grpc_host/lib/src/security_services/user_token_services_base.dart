import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:nosql_repository/nosql_repository.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class UserTokenServicesBase<TUser extends UserBase> {
  final TokenServicesParameters<TUser> parameters;
  final MapMapper<TUser> mapMapper;

  UserTokenServicesBase(
    this.parameters,
    this.mapMapper,
  );

  int? get maxNumberOfFailedLoginAttempts => null;

  TUser copyUserWith(
    TUser user, {
    int? numberOfFailedAttempts,
    bool? isLocked,
  });

  UserRepositoryBase get _userRepository => parameters.userRepository;
  JsonWebTokenHandler get _tokenHandler => parameters.tokenHandler;

  Future<UserToken> create(String username,
      Future<bool> Function(TUser user) isUserAuthenticated) async {
    TUser user;
    try {
      user = await _getUserFromUsername(username);
      if (user.isLocked) {
        throw GrpcError.permissionDenied('user is locked');
      }
    } on NotFound {
      throw GrpcError.notFound('User is not found');
    }

    final isAuthenticated = await isUserAuthenticated(user);
    if (!isAuthenticated) {
      await _handleFailedAuthentication(user);
      throw GrpcError.unauthenticated('username or password is invalid');
    }

    var payload = user.toJwtPayload(
      issuer: parameters.tokenIssuer,
      audience: parameters.tokenAudience,
      timeToLive: parameters.tokenTimeToLive,
    );

    final token = _generateToken(payload, user);
    return token;
  }

  Future<UserToken> renew(String tokenJwt) async {
    final payload = parameters.tokenHandler.load(tokenJwt);

    TUser user;
    try {
      user = await _getUserFromUsername(payload.username);
    } on NotFound {
      throw GrpcError.notFound('User is not found');
    }

    final newPayload = payload.CopyWith(
      notBefore: DateTime.now(),
      expires: DateTime.now().add(parameters.tokenTimeToLive).toUtc(),
    );
    final newToken = _generateToken(newPayload, user);
    return newToken;
  }

  UserToken _generateToken(JwtPayload payload, TUser user) {
    final token = _tokenHandler.generate(payload);

    var ret = UserToken<TUser>(
      user: user,
      token: token,
      expires: payload.expires,
    );
    return ret;
  }

  Future<TUser> _getUserFromUsername(String username) async {
    final userMap = await _userRepository.getFromUsername(username);
    final user = mapMapper.fromMap(userMap);
    return user;
  }


  Future<TUser> _handleFailedAuthentication(TUser user) async {
    final failedAttempts = user.numberOfFailedAttempts + 1;
    final isLocked = user.isLocked ||
        (maxNumberOfFailedLoginAttempts != null &&
            failedAttempts > maxNumberOfFailedLoginAttempts!);
    user = copyUserWith(
      user,
      numberOfFailedAttempts: failedAttempts,
      isLocked: isLocked,
    );

    var userMap = mapMapper.toMap(user);
    userMap = await _userRepository.updateUser(user.key, userMap);
    user = mapMapper.fromMap(userMap);
    return user;
  }

}
