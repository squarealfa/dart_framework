import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'category.g.dart';

@validatable
class Category {
  @required
  final String title;

  Category({
    required this.title,
  });
}
