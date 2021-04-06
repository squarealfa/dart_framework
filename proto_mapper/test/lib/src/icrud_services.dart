import 'package:proto_generator_test/src/key.dart';

import 'empty.dart';

abstract class ICrudServices<TEntity> {
  Future<TEntity> create(TEntity entity);
  Future<TEntity> update(TEntity entity);
  Future<Empty> delete(Key key);
  Future<TEntity> get(Key key);
}
