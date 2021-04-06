// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_services_base.dart';

// **************************************************************************
// ProtoServicesGenerator
// **************************************************************************

typedef RecipeServiceFactory = RecipeServiceBase Function(ServiceCall call);

class GRecipeService extends GRecipeServiceBase {
  final RecipeServiceFactory factory;

  GRecipeService(this.factory);

  RecipeServiceBase createService(ServiceCall call) {
    final ret = factory(call);
    return ret;
  }

  @override
  Future<GRecipe> create(
    ServiceCall call,
    GRecipe request,
  ) async {
    final service = createService(call);

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
    final service = createService(call);

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
    final service = createService(call);

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
    final service = createService(call);

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
    final service = createService(call);

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
    final service = createService(call);

    final entity = request.toCalcParameters();
    final result = await service.doCalculation(entity);
    final protoResult = result.toProto();
    return protoResult;
  }
}
