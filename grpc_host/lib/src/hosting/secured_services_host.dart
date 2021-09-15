import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:squarealfa_security/squarealfa_security.dart';

abstract class SecuredServicesHost extends ServicesHost {
  SecuredServicesHost(HostParameters parameters) : super(parameters);

  JwtPayload getTokenPayload(String token);
  Future<Principal> createPrincipal(JwtPayload payload);

  @override
  List<Interceptor> get interceptors => [
        ...super.interceptors,
        (call, method) async {
          await call.authenticate(
            getTokenPayload: getTokenPayload,
            createPrincipal: createPrincipal,
          );
        }
      ];
}
