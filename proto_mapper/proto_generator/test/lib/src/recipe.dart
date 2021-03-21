import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator_test/grpc/appliance_type.pbenum.dart';
import 'package:proto_generator_test/grpc/recipe.pb.dart';
import 'package:proto_generator_test/src/appliance_type.dart';
import 'category.dart';
import 'ingredient.dart';

part 'recipe.g.dart';

@proto
@mapProto
class Recipe {
  final String title;
  final String? description;
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
    required this.title,
    required this.category,
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
  });
}
