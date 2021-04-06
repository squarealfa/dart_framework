import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/src/icrud_services.dart';

import '../proto_generator_test.dart';
import 'empty.dart';

@protoServices
abstract class IRecipeServices extends ICrudServices {
  Future<List<Recipe>> search(Empty empty);
}

/**
 * 
 * // GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ProtoGenerator
// **************************************************************************

syntax = "proto3";

import 'category.proto';
import 'ingredient.proto';
import 'appliance_type.proto';

service GRecipeServices {

  rpc Search (GEmpty) returns (GListOfRecipe);
  rpc Get(GKey) returns (GRecipe);

  rpc Create(GRecipe) returns (GRecipe);
  rpc Update(GRecipe) returns (GRecipe);
  rpc Delete(GKey) returns (GEmpty);
}





 * 
 */