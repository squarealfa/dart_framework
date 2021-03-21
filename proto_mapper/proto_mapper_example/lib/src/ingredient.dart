import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_annotations/src/annotations/proto.dart';
import 'grpc/ingredient.pb.dart';

part 'ingredient.g.dart';

@Proto()
@MapProto()
class Ingredient {
  final String description;
  final double quantity;

  const Ingredient({
    required this.description,
    required this.quantity,
  });
}
