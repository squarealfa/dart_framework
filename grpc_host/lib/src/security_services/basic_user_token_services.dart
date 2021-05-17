import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

class BasicUserTokenServices<TUser extends BasicUserBase>
    extends UserTokenServices<TUser> {
  BasicUserTokenServices(
      TokenServicesParameters<TUser> parameters, ServiceCall call)
      : super(parameters, call);

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
