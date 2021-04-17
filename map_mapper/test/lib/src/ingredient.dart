import 'package:decimal/decimal.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'component.dart';

part 'ingredient.g.dart';

@mapMap
class Ingredient {
  final String key;
  final String description;
  final Decimal quantity;
  final double precision;
  final Duration cookingDuration;

  final String mainComponentKey;
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
    this.key = '',
    this.mainComponentKey = '',
  });
}
