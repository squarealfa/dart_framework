import 'dart:isolate';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:security_repository/security_repository.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class ServicesHost {
  final HostParameters parameters;
  final HostSettings hostSettings;
  ServicesHost(this.parameters) : hostSettings = parameters.hostSettings;

  Container get container => Container();

  List<Service> get services;

  Future init();
  UserRepository createUserRepository();

  Future registerContainedDependencies() async {}

  Future run() async {
    await init();
    final userRepository = createUserRepository();
    final tokenSettings = hostSettings.tokenSettings;
    final tokenHandler = JsonWebTokenHandler(tokenSettings.key);
    final tsp = TokenServicesParameters(
      userRepository: userRepository,
      tokenHandler: tokenHandler,
      tokenIssuer: tokenSettings.issuer,
      tokenAudience: tokenSettings.audience,
    );

    Container().registerInstance<TokenServicesParameters>(tsp);

    await registerContainedDependencies();

    var server = Server([
      ...services,
    ], [
      (call, method) async {
        await call.authenticate(tsp, userRepository);
      }
    ]);

    await server.serve(
      port: hostSettings.port,
      shared: true,
    );

    print(
        'Isolate ${Isolate.current.hashCode} serving at port ${hostSettings.port}. Will try to open connection to database.');
  }
}
