abstract class MapMapper<TEntity> {
  TEntity fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(TEntity entity);

  T getValueOrDefault<T>(dynamic source, T Function() getDefault,
          T Function(dynamic) getFromSource) =>
      source == null ? getDefault() : getFromSource(source);
}
