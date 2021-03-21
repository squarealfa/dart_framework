class ProtoBase {
  final String packageName;
  final String? prefix;
  final bool includeFieldsByDefault;
  final bool nullableFieldsByDefault;

  const ProtoBase({
    this.prefix = '',
    this.packageName = '',
    this.includeFieldsByDefault = true,
    this.nullableFieldsByDefault = false,
  });
}
