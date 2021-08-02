/// Defines a property to be returned by a search query
class ReturnField {
  /// defines the name key in the Map<String, dynamic>
  /// of this property of the document that is returned.
  final String? alias;

  /// path in the queried documents to search for the
  /// returned field.
  final String path;

  const ReturnField(
    this.path, [
    this.alias,
  ]);
}
