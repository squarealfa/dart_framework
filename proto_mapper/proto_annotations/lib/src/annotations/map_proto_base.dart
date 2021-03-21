class MapProtoBase {
  final String? packageName;
  final String? prefix;
  final bool includeFieldsByDefault;

  const MapProtoBase({
    this.prefix,
    this.packageName,
    this.includeFieldsByDefault = true,
  });
}
