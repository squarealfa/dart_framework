import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'appliance_type.dart';
import 'category.dart';
import 'ingredient.dart';

part 'recipe.g.dart';

@mapMap
class Recipe {
  final String key;
  final String title;
  final String? description;
  final String categoryKey;
  final String? secondaryCategoryKey;
  final Category category;
  final List<Ingredient> ingredients;
  final DateTime publishDate;
  final DateTime? expiryDate;
  final Duration preparationDuration;
  final Duration? totalDuration;
  final bool isPublished;
  final bool? requiresRobot;

  final ApplianceType mainApplianceType;
  final ApplianceType? secondaryApplianceType;

  final List<String> tags;
  final List<String>? extraTags;

  Recipe({
    this.key = '',
    required this.title,
    required this.category,
    required this.categoryKey,
    required this.ingredients,
    required this.publishDate,
    required this.preparationDuration,
    required this.isPublished,
    required this.mainApplianceType,
    required this.tags,
    this.description,
    this.expiryDate,
    this.totalDuration,
    this.requiresRobot,
    this.secondaryApplianceType,
    this.extraTags,
    this.secondaryCategoryKey,
  });
}
