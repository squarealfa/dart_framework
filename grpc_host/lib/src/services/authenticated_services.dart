import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';

class AuthenticatedServices {
  final ServiceCall call;
  final Principal principal;

  AuthenticatedServices(this.call) : principal = call.principal {
    principal.throwIfUnauthenticated();
  }

  void throwOnError(ErrorList errors) {
    if (errors.hasErrors) throw errors;
  }

  void throwUnauthorized() {
    throw GrpcError.unauthenticated('Unauthorized');
  }

  void throwNotFound() {
    throw GrpcError.notFound();
  }
}
