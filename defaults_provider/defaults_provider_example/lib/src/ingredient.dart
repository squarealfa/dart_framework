import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';

part 'ingredient.g.dart';

@defaultsProvider
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}
