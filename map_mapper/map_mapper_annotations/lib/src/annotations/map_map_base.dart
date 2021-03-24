abstract class MapMapBase {
  /// Determines whether to include all fields by default.
  ///
  /// When the value is true, all fields that do not have
  /// the [MapIgnore] annotation will be mapped.
  /// When the value is false, only the fields that have the
  /// [MapField] annotation will be included.
  final bool includeFieldsByDefault;
  final bool useDefaultsProvider;

  const MapMapBase({
    this.includeFieldsByDefault = true,
    this.useDefaultsProvider = false,
  });
}
