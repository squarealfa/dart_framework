import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/calc_parameters.pb.dart';

part 'calc_parameters.g.dart';

@proto
@mapProto
class CalcParameters {
  final int parameter1;
  final int parameter2;

  CalcParameters({
    required this.parameter1,
    required this.parameter2,
  });
}
