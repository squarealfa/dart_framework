import 'package:map_mapper_annotations/map_mapper_annotations.dart';

import 'component.dart';

part 'category.g.dart';

@mapMap
class Category {
  final String title;
  final Component mainComponent;
  final Component? alternativeComponent;
  final List<Component> otherComponents;
  final List<Component>? secondaryComponents;

  Category({
    required this.title,
    required this.mainComponent,
    required this.otherComponents,
    this.alternativeComponent,
    this.secondaryComponents,
  });
}
