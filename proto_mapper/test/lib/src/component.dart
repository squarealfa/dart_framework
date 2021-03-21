import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/component.pb.dart';

part 'component.g.dart';

@proto
@mapProto
class Component {
  final String description;

  Component({
    required this.description,
  });
}
