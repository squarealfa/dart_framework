/// Annotation that instructs the code generator to
/// build a subclass of [BuildBuilder] for the
/// class to which it is applied
class BuildBuilder {
  final bool createBuilderBaseClass;
  const BuildBuilder({
    this.createBuilderBaseClass = false,
  });
}

const builder = BuildBuilder();
