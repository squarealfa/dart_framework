import 'package:grpc/grpc.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/calc_parameters.pb.dart';
import 'package:proto_generator_test/grpc/calc_result.pb.dart';
import 'package:proto_generator_test/grpc/empty.pb.dart';
import 'package:proto_generator_test/grpc/key.pb.dart';
import 'package:proto_generator_test/grpc/recipe.pb.dart';
import 'package:proto_generator_test/grpc/recipe_services_base.pbgrpc.dart';
import 'package:proto_generator_test/src/calc_parameters.dart';
import 'package:proto_generator_test/src/calc_result.dart';
import 'package:proto_generator_test/src/crud_services_base.dart';

import '../proto_generator_test.dart';
import 'empty.dart';
import 'key.dart';

part 'recipe_services_base.g.dart';

@proto
@protoServices
abstract class RecipeServiceBase extends CrudServicesBase<Recipe> {
  Future<List<Recipe>> search(Empty empty);

  CalcResult doCalculation(CalcParameters parameters);
}
