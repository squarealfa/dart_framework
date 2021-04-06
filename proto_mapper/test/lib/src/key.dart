import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/key.pb.dart';

part 'key.g.dart';

@proto
@mapProto
class Key {
  final String key;
  const Key({
    required this.key,
  });
}
