class MapProtoServices {
  final String? prefix;
  final String packageName;
  final bool withAuthenticator;
  const MapProtoServices({
    this.prefix,
    this.packageName = '',
    this.withAuthenticator = true,
  });
}

const mapProtoServices = MapProtoServices();
