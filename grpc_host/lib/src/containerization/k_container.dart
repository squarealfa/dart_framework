import 'package:grpc_host/grpc_host.dart';
import 'package:kiwi/kiwi.dart';

class KContainer extends Container {
  KContainer() : super.instance();

  @override
  T resolve<T>() {
    final ret = KiwiContainer().resolve<T>();
    return ret;
  }

  @override
  void registerInstance<S>(S instance, {String? name}) =>
      KiwiContainer().registerInstance(
        instance,
        name: name,
      );
}
