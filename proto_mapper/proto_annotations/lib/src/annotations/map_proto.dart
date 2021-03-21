import 'map_proto_base.dart';

class MapProto extends MapProtoBase {
  const MapProto({
    String? prefix,
    String? packageName,
    bool includeFieldsByDefault = true,
  }) : super(
          prefix: prefix,
          packageName: packageName,
          includeFieldsByDefault: includeFieldsByDefault,
        );
}

const mapProto = MapProto();
