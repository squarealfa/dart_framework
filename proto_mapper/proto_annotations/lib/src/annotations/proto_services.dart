class ProtoServices {
  final String? prefix;
  final String packageName;
  final bool withAuthenticator;
  const ProtoServices({
    this.prefix,
    this.packageName = '',
    this.withAuthenticator = true,
  });
}

const protoServices = ProtoServices();
