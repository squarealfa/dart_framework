class ProtoBase {
  final String packageName;
  final String? prefix;
  final bool includeFieldsByDefault;

  const ProtoBase({
    this.prefix = '',
    this.packageName = '',
    this.includeFieldsByDefault = true,
  });
}
