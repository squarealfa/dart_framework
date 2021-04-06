import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/empty.pb.dart';

part 'empty.g.dart';

@proto
@mapProto
class Empty {
  const Empty();
}
