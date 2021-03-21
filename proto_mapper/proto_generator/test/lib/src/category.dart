import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/category.pb.dart';

import 'component.dart';

part 'category.g.dart';

@proto
@mapProto
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
