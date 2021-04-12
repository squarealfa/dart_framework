import 'dart:io';
import 'dart:isolate';

import 'package:grpc_host/grpc_host.dart';

import 'host_parameters.dart';

Future serve(void Function(HostParameters message) entryPoint) async {
  var appSettings = AppSettings();
  var receivePort = ReceivePort();
  var errorReceivePort = ReceivePort();
  var hostParameters = HostParameters(receivePort.sendPort, appSettings);
  var isolates = <Isolate>[];
  for (var i = 0; i < appSettings.numberIsolates; i++) {
    var isolate =
        await Isolate.spawn(entryPoint, hostParameters, errorsAreFatal: false);
    isolate.addErrorListener(errorReceivePort.sendPort);
    isolates.add(isolate);
  }

  receivePort.listen((msg) {
    print(msg);
  });

  errorReceivePort.listen((msg) {
    stderr.writeln('ERROR $msg');
  });
}
