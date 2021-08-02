/// Defines a sorting order
class OrderBy {
  /// which path in the queried documents
  /// to find the field on which the sort
  /// is applied to
  final String path;

  /// when true, sort is descending.
  final bool isDescending;

  const OrderBy(this.path, {this.isDescending = false});
}
