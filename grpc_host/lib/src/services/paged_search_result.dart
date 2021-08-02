class PagedSearchResult<TEntity> {
  final int count;
  final List<TEntity> page;

  PagedSearchResult({
    required this.count,
    required this.page,
  });
}
