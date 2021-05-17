import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class BasicUserTokenServices<TUser extends BasicUserBase<TUserCache>,
        TUserCache extends UserCacheBase>
    extends UserTokenServicesBase<TUser, TUserCache> {
  BasicUserTokenServices(
    TokenServicesParameters<TUser, TUserCache> parameters,
    ServiceCall call,
    MapMapper<TUser> mapMapper,
  ) : super(parameters, call, mapMapper);

  Future<bool> isUserAuthenticated(TUser user, String password) async {
    var hash = await Password.getSaltedPasswordHash(
      user.passwordSalt,
      password,
    );
    final ret = hash == user.passwordHash;
    return ret;
  }

  Future<UserToken> createFromBasicUser(
      String username, String password) async {
    final ret =
        create(username, (user) async => isUserAuthenticated(user, password));
    return ret;
  }
}
