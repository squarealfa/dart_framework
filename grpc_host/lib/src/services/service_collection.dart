import 'package:grpc/grpc.dart';
import 'package:grpc_host/grpc_host.dart';

abstract class ServiceCollection {
  final Container container;

  ServiceCollection(this.container);

  List<Service> get services;
}
