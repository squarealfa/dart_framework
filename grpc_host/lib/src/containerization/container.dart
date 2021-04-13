import 'k_container.dart';

abstract class Container {
  static Container container = KContainer();

  Container.instance();

  factory Container() => container;

  T resolve<T>();

  void registerInstance<S>(
    S instance, {
    String? name,
  });
}
