// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class RecipeProtoMapper implements ProtoMapper<Recipe, GRecipe> {
  static final RecipeProtoMapper _singleton = RecipeProtoMapper._();

  RecipeProtoMapper._();
  factory RecipeProtoMapper() => _singleton;

  @override
  Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);

  @override
  GRecipe toProto(Recipe entity) => _$RecipeToProto(entity);

  Recipe fromJson(String json) => _$RecipeFromProto(GRecipe.fromJson(json));
  String toJson(Recipe entity) => _$RecipeToProto(entity).writeToJson();
}

GRecipe _$RecipeToProto(Recipe instance) {
  var proto = GRecipe();

  proto.title = instance.title;
  if (instance.description != null) {
    proto.description = instance.description!;
  }
  proto.descriptionHasValue = instance.description != null;

  proto.category = CategoryProtoMapper().toProto(instance.category);
  proto.ingredients.addAll(
      instance.ingredients.map((e) => IngredientProtoMapper().toProto(e)));

  proto.publishDate = Int64(instance.publishDate.millisecondsSinceEpoch);
  if (instance.expiryDate != null) {
    proto.expiryDate = Int64(instance.expiryDate!.millisecondsSinceEpoch);
  }
  proto.expiryDateHasValue = instance.expiryDate != null;

  proto.preparationDuration =
      instance.preparationDuration.inMilliseconds.toDouble();
  if (instance.totalDuration != null) {
    proto.totalDuration = instance.totalDuration!.inMilliseconds.toDouble();
  }
  proto.totalDurationHasValue = instance.totalDuration != null;

  proto.isPublished = instance.isPublished;
  if (instance.requiresRobot != null) {
    proto.requiresRobot = instance.requiresRobot!;
  }
  proto.requiresRobotHasValue = instance.requiresRobot != null;

  proto.mainApplianceType =
      GApplianceType.valueOf(instance.mainApplianceType.index)!;
  if (instance.secondaryApplianceType != null) {
    proto.secondaryApplianceType =
        GApplianceType.valueOf(instance.secondaryApplianceType!.index)!;
  }
  proto.secondaryApplianceTypeHasValue =
      instance.secondaryApplianceType != null;

  proto.tags.addAll(instance.tags);

  proto.extraTags.addAll(instance.extraTags ?? []);
  proto.extraTagsHasValue = instance.extraTags != null;

  return proto;
}

Recipe _$RecipeFromProto(GRecipe instance) => Recipe(
      title: instance.title,
      description:
          (instance.descriptionHasValue ? (instance.description) : null),
      category: CategoryProtoMapper().fromProto(instance.category),
      ingredients: instance.ingredients
          .map((e) => IngredientProtoMapper().fromProto(e))
          .toList(),
      publishDate:
          DateTime.fromMillisecondsSinceEpoch(instance.publishDate.toInt()),
      expiryDate: (instance.expiryDateHasValue
          ? (DateTime.fromMillisecondsSinceEpoch(instance.expiryDate.toInt()))
          : null),
      preparationDuration:
          Duration(milliseconds: instance.preparationDuration.toInt()),
      totalDuration: (instance.totalDurationHasValue
          ? (Duration(milliseconds: instance.totalDuration.toInt()))
          : null),
      isPublished: instance.isPublished,
      requiresRobot:
          (instance.requiresRobotHasValue ? (instance.requiresRobot) : null),
      mainApplianceType: ApplianceType.values[instance.mainApplianceType.value],
      secondaryApplianceType: (instance.secondaryApplianceTypeHasValue
          ? (ApplianceType.values[instance.secondaryApplianceType.value])
          : null),
      tags: instance.tags.map((e) => e).toList(),
      extraTags: (instance.extraTagsHasValue
          ? (instance.extraTags.map((e) => e).toList())
          : null),
    );

extension RecipeProtoExtension on Recipe {
  GRecipe toProto() => _$RecipeToProto(this);
  String toJson() => _$RecipeToProto(this).writeToJson();

  static Recipe fromProto(GRecipe proto) => _$RecipeFromProto(proto);
  static Recipe fromJson(String json) =>
      _$RecipeFromProto(GRecipe.fromJson(json));
}

extension GRecipeProtoExtension on GRecipe {
  Recipe toRecipe() => _$RecipeFromProto(this);
}
