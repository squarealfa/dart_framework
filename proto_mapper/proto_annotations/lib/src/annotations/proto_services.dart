class ProtoServices {
  const ProtoServices({
    this.prefix,
    this.packageName = '',
  });
  final String packageName;
  final String? prefix;
}

const protoServices = ProtoServices();
