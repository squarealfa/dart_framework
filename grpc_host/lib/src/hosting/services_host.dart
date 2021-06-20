import 'dart:io';
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

    final server = Server(services, interceptors);
    final serverTlsCredentials = await _getServerTlsCredentials();

    await server.serve(
      port: hostSettings.port,
      shared: true,
      security: serverTlsCredentials,
    );

    print(
        'Isolate ${Isolate.current.hashCode} serving at port ${hostSettings.port}.');
  }

  Future<ServerTlsCredentials?> _getServerTlsCredentials() async {
    final sslSettings = hostSettings.sslSettings;
    if (sslSettings.certificatePath.isEmpty) {
      return null;
    }

    final List<int> certificate =
        await File(sslSettings.certificatePath).readAsBytes();
    final List<int>? privateKey = sslSettings.privateKeyPath.isEmpty
        ? null
        : await File(sslSettings.privateKeyPath).readAsBytes();

    return ServerTlsCredentials(
      certificate: certificate,
      privateKey: privateKey,
    );
  }
}
