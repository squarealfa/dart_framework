import 'package:decimal/decimal.dart';
import 'package:squarealfa_entity_annotations/squarealfa_entity_annotations.dart';

part 'ingredient.g.dart';

@validatable
class Ingredient {
  @StringLength(minLength: 10)
  final String description;

  @StringLength(maxLength: 10)
  final String? notes;

  @StringLength(minLength: 2)
  final String? tag;

  @Range(minValue: 10.0, maxValue: 20)
  final double quantity;

  @Range(minValue: 10)
  final Decimal precision;

  @Range(minValue: 10, maxValue: 20)
  final int intQuantity;

  @Range(minValue: 10, maxValue: 20)
  final int? nintQuantity;

  @Range(minValue: 10, maxValue: 20)
  @required
  final int? rInt;

  Ingredient({
    required this.description,
    required this.quantity,
    required this.precision,
    required this.intQuantity,
    this.notes,
    this.tag,
    this.nintQuantity,
    this.rInt,
  });
}
