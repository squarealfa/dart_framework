class MapProto {
  const MapProto({
    this.prefix,
    this.packageName = '',
    this.includeFieldsByDefault = true,
  });

  final String? packageName;
  final String? prefix;
  final bool includeFieldsByDefault;
}

const mapProto = MapProto();
