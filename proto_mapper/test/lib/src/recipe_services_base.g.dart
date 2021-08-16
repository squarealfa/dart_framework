// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_services_base.dart';

// **************************************************************************
// ProtoServicesGenerator
// **************************************************************************

typedef RecipeServiceFactory = RecipeServiceBase Function(ServiceCall call);

class GRecipeService extends GRecipeServiceBase {
  final RecipeServiceFactory $serviceFactory;
  final void Function(ServiceCall call) $authenticator;

  GRecipeService(
    this.$serviceFactory,
    this.$authenticator,
  );

  @override
  void $onMetadata(ServiceCall call) {
    $authenticator(call);
  }

  @override
  Future<GRecipe> create(
    ServiceCall call,
    GRecipe request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toRecipe();
    final result = await service.create(entity);
    final protoResult = result.toProto();
    return protoResult;
  }

  @override
  Future<GRecipe> update(
    ServiceCall call,
    GRecipe request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toRecipe();
    final result = await service.update(entity);
    final protoResult = result.toProto();
    return protoResult;
  }

  @override
  Future<GEmpty> delete(
    ServiceCall call,
    GKey request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toKey();
    final result = await service.delete(entity);
    final protoResult = result.toProto();
    return protoResult;
  }

  @override
  Future<GRecipe> get(
    ServiceCall call,
    GKey request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toKey();
    final result = await service.get(entity);
    final protoResult = result.toProto();
    return protoResult;
  }

  @override
  Future<GListOfRecipe> search(
    ServiceCall call,
    GEmpty request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toEmpty();
    final result = await service.search(entity);
    final protoResult = GListOfRecipe()
      ..items.addAll(result.map((i) => i.toProto()));
    return protoResult;
  }

  @override
  Future<GCalcResult> doCalculation(
    ServiceCall call,
    GCalcParameters request,
  ) async {
    final service = $serviceFactory(call);

    final entity = request.toCalcParameters();
    final result = service.doCalculation(entity);
    final protoResult = result.toProto();
    return protoResult;
  }
}

// **************************************************************************
// ProtoServicesClientGenerator
// **************************************************************************

abstract class RecipeServiceClientBase implements RecipeServiceBase {
  Future<GRecipeServiceClient> getGServiceClient();

  @override
  Future<Recipe> create(Recipe entity) async {
    final serviceClient = await getGServiceClient();
    final _entity = entity.toProto();
    final _result = (await serviceClient.create(_entity));
    final result = _result.toRecipe();
    return result;
  }

  @override
  Future<Recipe> update(Recipe entity) async {
    final serviceClient = await getGServiceClient();
    final _entity = entity.toProto();
    final _result = (await serviceClient.update(_entity));
    final result = _result.toRecipe();
    return result;
  }

  @override
  Future<Empty> delete(Key key) async {
    final serviceClient = await getGServiceClient();
    final _key = key.toProto();
    final _result = (await serviceClient.delete(_key));
    final result = _result.toEmpty();
    return result;
  }

  @override
  Future<Recipe> get(Key key) async {
    final serviceClient = await getGServiceClient();
    final _key = key.toProto();
    final _result = (await serviceClient.get(_key));
    final result = _result.toRecipe();
    return result;
  }

  @override
  Future<List<Recipe>> search(Empty empty) async {
    final serviceClient = await getGServiceClient();
    final _empty = empty.toProto();
    final _result = (await serviceClient.search(_empty));
    final result = _result.items.map((a) => a.toRecipe()).toList();
    return result;
  }
}
