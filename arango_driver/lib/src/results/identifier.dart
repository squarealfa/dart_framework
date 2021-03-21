/// Represents a document identifier, composed of its
/// id, key and rev
class Identifier {
  final String id;
  final String key;
  final String rev;

  const Identifier({
    required this.id,
    required this.key,
    required this.rev,
  });
}
