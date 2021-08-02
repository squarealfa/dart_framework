/// Represents the result of a search, containing a
/// stream of entities that constitute a page of
/// results and the total count of entities that
/// fit the criteria given in the search.
class SearchResult {
  // stream of entities that constitute a page of results
  final Stream<Map<String, dynamic>> page;

  // total count of entities that fit the criteria.
  final int count;

  const SearchResult(this.page, this.count);
}
