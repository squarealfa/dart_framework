class DefaultsProvider {
  const DefaultsProvider({
    this.createDefaultsProviderBaseClass = false,
  });
  final bool createDefaultsProviderBaseClass;
}

const defaultsProvider = DefaultsProvider();
