import 'proto_base.dart';

class Proto extends ProtoBase {
  const Proto({
    String? prefix,
    String packageName = '',
    bool includeFieldsByDefault = true,
  }) : super(
          prefix: prefix,
          packageName: packageName,
          includeFieldsByDefault: includeFieldsByDefault,
        );
}

const proto = Proto();
