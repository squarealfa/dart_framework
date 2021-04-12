import 'dart:isolate';

import 'package:grpc_host/grpc_host.dart';

class HostParameters {
  final SendPort sendPort;
  final AppSettings appSettings;

  const HostParameters(this.sendPort, this.appSettings);
}
