import '../defaults_provider_annotations.dart';

class DefaultsProvider extends DefaultsProviderBase {
  const DefaultsProvider({
    bool createDefaultsProviderBaseClass = false,
  }) : super(createDefaultsProviderBaseClass: createDefaultsProviderBaseClass);
}

const defaultsProvider = DefaultsProvider();
