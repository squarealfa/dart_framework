import 'package:nosql_repository/nosql_repository.dart';

import 'recipe.dart';

abstract class RepositoryTestHandler {
  Future<Repository<Recipe>> createRepositoryForCleanCollection();
  String getIdFromMap(Map<String, dynamic> map, [String? fieldName]);
  Map<String, dynamic> toIdMap(String key);
  String mapKeyFieldName(String keyFieldName);
}
