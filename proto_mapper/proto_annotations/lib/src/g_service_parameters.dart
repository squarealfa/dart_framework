import 'package:grpc/grpc.dart';

class GServiceParameters<TServiceBase> {
  TServiceBase Function(ServiceCall call) serviceBaseFactory;
  void Function(ServiceCall call)? onMetadataHandler;

  GServiceParameters(this.serviceBaseFactory, [this.onMetadataHandler]);
}
