import 'package:map_mapper_annotations/map_mapper_annotations.dart';

/// Converts instances of type [TEntity] to Map<String, dynamic>
/// and from Map<String, dynamic> to [TEntity]
abstract class MapMapper<TEntity> {
  /// Converts a Map<String, dynamic> into a new instance of [TEntity]
  TEntity fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]);

  /// Converts an instance of [TEntity] into a new Map<String, dynamic>
  Map<String, dynamic> toMap(TEntity entity, [KeyHandler? keyHandler]);

  T getValueOrDefault<T>(dynamic source, T Function() getDefault,
          T Function(dynamic) getFromSource) =>
      source == null ? getDefault() : getFromSource(source);
}
