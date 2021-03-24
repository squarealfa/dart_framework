import 'map_proto_base.dart';

class MapProto extends MapProtoBase {
  const MapProto({
    String? prefix,
    String? packageName,
  }) : super(
          prefix: prefix,
          packageName: packageName,
        );
}

const mapProto = MapProto();
