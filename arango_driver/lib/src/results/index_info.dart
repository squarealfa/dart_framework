import '../index_type.dart';

class IndexInfo {
  final String id;
  final String name;
  final bool isNewlyCreated;
  final List<String> fields;
  final IndexType type;
  final bool unique;
  final bool deduplicate;
  final bool sparse;
  final int selectivityEstimate;

  const IndexInfo({
    required this.id,
    required this.name,
    required this.isNewlyCreated,
    required this.fields,
    required this.type,
    required this.unique,
    required this.deduplicate,
    required this.sparse,
    required this.selectivityEstimate,
  });
}
