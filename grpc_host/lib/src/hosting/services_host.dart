import 'dart:isolate';

import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';

abstract class ServicesHost {
  final HostParameters parameters;
  final HostSettings hostSettings;
  ServicesHost(this.parameters) : hostSettings = parameters.hostSettings;

  Container get container => Container();

  List<Service> get services;

  Future init() async {}

  Future registerContainedDependencies() async {}

  List<Interceptor> get interceptors => [];

  Future run() async {
    await init();

    await registerContainedDependencies();

    var server = Server(services, interceptors);

    await server.serve(
      port: hostSettings.port,
      shared: true,
    );

    print(
        'Isolate ${Isolate.current.hashCode} serving at port ${hostSettings.port}.');
  }
}
