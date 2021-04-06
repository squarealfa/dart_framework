///
//  Generated code. Do not modify.
//  source: recipe_services_base.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'recipe.pb.dart' as $0;
import 'key.pb.dart' as $1;
import 'empty.pb.dart' as $2;
import 'calc_parameters.pb.dart' as $3;
import 'calc_result.pb.dart' as $4;
export 'recipe_services_base.pb.dart';

class GRecipeServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.GRecipe, $0.GRecipe>(
      '/GRecipeService/Create',
      ($0.GRecipe value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GRecipe.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.GRecipe, $0.GRecipe>(
      '/GRecipeService/Update',
      ($0.GRecipe value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GRecipe.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.GKey, $2.GEmpty>(
      '/GRecipeService/Delete',
      ($1.GKey value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GEmpty.fromBuffer(value));
  static final _$get = $grpc.ClientMethod<$1.GKey, $0.GRecipe>(
      '/GRecipeService/Get',
      ($1.GKey value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GRecipe.fromBuffer(value));
  static final _$search = $grpc.ClientMethod<$2.GEmpty, $0.GListOfRecipe>(
      '/GRecipeService/Search',
      ($2.GEmpty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GListOfRecipe.fromBuffer(value));
  static final _$doCalculation =
      $grpc.ClientMethod<$3.GCalcParameters, $4.GCalcResult>(
          '/GRecipeService/DoCalculation',
          ($3.GCalcParameters value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.GCalcResult.fromBuffer(value));

  GRecipeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GRecipe> create($0.GRecipe request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.GRecipe> update($0.GRecipe request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$2.GEmpty> delete($1.GKey request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.GRecipe> get($1.GKey request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.GListOfRecipe> search($2.GEmpty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$search, request, options: options);
  }

  $grpc.ResponseFuture<$4.GCalcResult> doCalculation($3.GCalcParameters request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$doCalculation, request, options: options);
  }
}

abstract class GRecipeServiceBase extends $grpc.Service {
  $core.String get $name => 'GRecipeService';

  GRecipeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GRecipe, $0.GRecipe>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GRecipe.fromBuffer(value),
        ($0.GRecipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GRecipe, $0.GRecipe>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GRecipe.fromBuffer(value),
        ($0.GRecipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GKey, $2.GEmpty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GKey.fromBuffer(value),
        ($2.GEmpty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GKey, $0.GRecipe>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GKey.fromBuffer(value),
        ($0.GRecipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GEmpty, $0.GListOfRecipe>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GEmpty.fromBuffer(value),
        ($0.GListOfRecipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GCalcParameters, $4.GCalcResult>(
        'DoCalculation',
        doCalculation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GCalcParameters.fromBuffer(value),
        ($4.GCalcResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.GRecipe> create_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GRecipe> request) async {
    return create(call, await request);
  }

  $async.Future<$0.GRecipe> update_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GRecipe> request) async {
    return update(call, await request);
  }

  $async.Future<$2.GEmpty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.GKey> request) async {
    return delete(call, await request);
  }

  $async.Future<$0.GRecipe> get_Pre(
      $grpc.ServiceCall call, $async.Future<$1.GKey> request) async {
    return get(call, await request);
  }

  $async.Future<$0.GListOfRecipe> search_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GEmpty> request) async {
    return search(call, await request);
  }

  $async.Future<$4.GCalcResult> doCalculation_Pre(
      $grpc.ServiceCall call, $async.Future<$3.GCalcParameters> request) async {
    return doCalculation(call, await request);
  }

  $async.Future<$0.GRecipe> create($grpc.ServiceCall call, $0.GRecipe request);
  $async.Future<$0.GRecipe> update($grpc.ServiceCall call, $0.GRecipe request);
  $async.Future<$2.GEmpty> delete($grpc.ServiceCall call, $1.GKey request);
  $async.Future<$0.GRecipe> get($grpc.ServiceCall call, $1.GKey request);
  $async.Future<$0.GListOfRecipe> search(
      $grpc.ServiceCall call, $2.GEmpty request);
  $async.Future<$4.GCalcResult> doCalculation(
      $grpc.ServiceCall call, $3.GCalcParameters request);
}
