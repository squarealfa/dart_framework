class CollectionInfo {
  final int type;
  final bool isSystem;
  final String id;
  final String globallyUniqueId;
  final String name;
  final int status;

  const CollectionInfo({
    required this.type,
    required this.isSystem,
    required this.id,
    required this.globallyUniqueId,
    required this.name,
    required this.status,
  });
}
