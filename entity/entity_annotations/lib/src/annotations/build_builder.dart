/// Annotation that instructs the code generator to
/// build a subclass of [BuildBuilder] for the
/// class to which it is applied
class BuildBuilder {
  final bool createBuilderBaseClass;
  final bool useDefaultsProvider;
  const BuildBuilder({
    this.createBuilderBaseClass = false,
    this.useDefaultsProvider = false,
  });
}

const builder = BuildBuilder();
