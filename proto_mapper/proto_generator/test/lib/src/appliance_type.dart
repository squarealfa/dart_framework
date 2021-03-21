import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/appliance_type.pbenum.dart';

part 'appliance_type.g.dart';

@proto
@mapProto
enum ApplianceType {
  Heat,
  Cold,
  Cutlery,
}
