class Proto {
  const Proto({
    this.prefix,
    this.packageName = '',
    this.includeFieldsByDefault = true,
  });
  final String packageName;
  final String? prefix;
  final bool includeFieldsByDefault;
}

const proto = Proto();
