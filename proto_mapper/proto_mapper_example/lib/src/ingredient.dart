import 'package:proto_annotations/src/annotations/proto.dart';

@Proto()
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}
