import 'map_map_base.dart';

/// Annotate PODO class with MapMap in order to
/// signal the code generator that it is to produce
/// a map mapper for the class to which the annotation
/// was applied.
class MapMap extends MapMapBase {
  const MapMap({
    bool includeFieldsByDefault = true,
    bool useDefaultsProvider = false,
  }) : super(
          includeFieldsByDefault: includeFieldsByDefault,
          useDefaultsProvider: useDefaultsProvider,
        );
}

const mapMap = MapMap();
