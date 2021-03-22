import 'package:map_mapper_annotations/map_mapper_annotations.dart';

part 'ingredient.g.dart';

@mapMap
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}
