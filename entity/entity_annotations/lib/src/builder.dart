import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

abstract class Builder<T> {
  T build();
  BuildResult<T> tryBuild();
}
