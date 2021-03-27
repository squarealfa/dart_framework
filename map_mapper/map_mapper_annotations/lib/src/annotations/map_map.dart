/// Annotate PODO class with MapMap in order to
/// signal the code generator that it is to produce
/// a map mapper for the class to which the annotation
/// was applied.
class MapMap {
  const MapMap({
    this.includeFieldsByDefault = true,
    this.useDefaultsProvider = false,
  });

  /// Determines whether to include all fields by default.
  ///
  /// When the value is true, all fields that do not have
  /// the [MapIgnore] annotation will be mapped.
  /// When the value is false, only the fields that have the
  /// [MapField] annotation will be included.
  final bool includeFieldsByDefault;
  final bool useDefaultsProvider;
}

const mapMap = MapMap();
