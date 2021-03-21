import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/ingredient.pb.dart';
import 'package:decimal/decimal.dart';
import 'component.dart';

part 'ingredient.g.dart';

@proto
@mapProto
class Ingredient {
  final String description;
  final Decimal quantity;
  final double precision;
  final Duration cookingDuration;

  final Component mainComponent;
  final List<Component> otherComponents;
  final Component? alternativeComponent;
  final List<Component>? secondaryComponents;

  Ingredient({
    required this.description,
    required this.quantity,
    required this.precision,
    required this.cookingDuration,
    required this.mainComponent,
    required this.otherComponents,
    this.alternativeComponent,
    this.secondaryComponents,
  });
}
