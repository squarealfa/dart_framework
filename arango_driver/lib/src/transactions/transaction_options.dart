class TransactionOptions {
  final List<String> readCollections;
  final List<String> writeCollections;
  final List<String> exclusiveCollections;
  final bool? waitForSync;
  final bool? allowImplicit;
  final int? lockTimeoutSeconds;
  final int? maxTransactionSizeBytes;

  const TransactionOptions({
    this.readCollections = const [],
    this.writeCollections = const [],
    this.exclusiveCollections = const [],
    this.waitForSync,
    this.allowImplicit,
    this.lockTimeoutSeconds,
    this.maxTransactionSizeBytes,
  });
}
