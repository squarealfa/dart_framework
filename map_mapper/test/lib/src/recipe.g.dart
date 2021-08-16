// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class RecipeMapMapper extends MapMapper<Recipe> {
  const RecipeMapMapper();

  @override
  Recipe fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();

    return Recipe(
      key: $kh.keyFromMap(map, 'key'),
      title: map['title'] as String,
      description: map['description'] as String?,
      categoryKey: $kh.keyFromMap(map, 'categoryKey'),
      secondaryCategoryKey: map['secondaryCategoryKey'] == null
          ? null
          : $kh.keyFromMap(map, 'secondaryCategoryKey'),
      category: const CategoryMapMapper().fromMap(map['category'], $kh),
      ingredients: List<Ingredient>.from(map['ingredients']
          .map((e) => const IngredientMapMapper().fromMap(e, $kh))),
      publishDate: DateTime.parse(map['publishDate']),
      expiryDate:
          map['expiryDate'] == null ? null : DateTime.parse(map['expiryDate']),
      preparationDuration: Duration(milliseconds: map['preparationDuration']),
      totalDuration: map['totalDuration'] == null
          ? null
          : Duration(milliseconds: map['totalDuration']),
      isPublished: map['isPublished'] as bool,
      requiresRobot: map['requiresRobot'] as bool?,
      mainApplianceType: ApplianceType.values[map['mainApplianceType'] as int],
      secondaryApplianceType: map['secondaryApplianceType'] == null
          ? null
          : ApplianceType.values[map['secondaryApplianceType'] as int],
      tags: List<String>.from(map['tags']),
      extraTags:
          map['extraTags'] == null ? null : List<String>.from(map['extraTags']),
    );
  }

  @override
  Map<String, dynamic> toMap(
    Recipe instance, [
    KeyHandler? keyHandler,
  ]) {
    final $kh = keyHandler ?? KeyHandler.fromDefault();
    final map = <String, dynamic>{};

    $kh.keyToMap(map, instance.key, 'key');
    map['title'] = instance.title;
    map['description'] = instance.description;
    $kh.keyToMap(map, instance.categoryKey, 'categoryKey');
    $kh.keyToMap(
        map, instance.secondaryCategoryKey ?? '', 'secondaryCategoryKey');
    map['category'] = const CategoryMapMapper().toMap(instance.category, $kh);
    map['ingredients'] = instance.ingredients
        .map((e) => const IngredientMapMapper().toMap(e, $kh))
        .toList();
    ;
    map['publishDate'] = instance.publishDate.toIso8601String();
    map['expiryDate'] = instance.expiryDate?.toIso8601String();
    map['preparationDuration'] = instance.preparationDuration.inMilliseconds;
    map['totalDuration'] = instance.totalDuration?.inMilliseconds;
    map['isPublished'] = instance.isPublished;
    map['requiresRobot'] = instance.requiresRobot;
    map['mainApplianceType'] = instance.mainApplianceType.index;
    map['secondaryApplianceType'] = instance.secondaryApplianceType?.index;
    map['tags'] = instance.tags;
    ;
    map['extraTags'] = instance.extraTags;
    ;

    return map;
  }
}

extension RecipeMapExtension on Recipe {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().toMap(this, keyHandler);
  static Recipe fromMap(Map<String, dynamic> map, [KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(map, keyHandler);
}

extension MapRecipeExtension on Map<String, dynamic> {
  Recipe toRecipe([KeyHandler? keyHandler]) =>
      const RecipeMapMapper().fromMap(this, keyHandler);
}

class $RecipeFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $RecipeFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _key = 'key';
  String get key => prefix + keyHandler.fieldNameToMapKey(_key);
  static const _title = 'title';
  String get title => prefix + _title;
  static const _description = 'description';
  String get description => prefix + _description;
  static const _categoryKey = 'categoryKey';
  String get categoryKey => prefix + keyHandler.fieldNameToMapKey(_categoryKey);
  static const _secondaryCategoryKey = 'secondaryCategoryKey';
  String get secondaryCategoryKey =>
      prefix + keyHandler.fieldNameToMapKey(_secondaryCategoryKey);
  static const _category = 'category';
  $CategoryFieldNames get category => $CategoryFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _category,
      );
  static const _ingredients = 'ingredients';
  $IngredientFieldNames get ingredients => $IngredientFieldNames(
        keyHandler: keyHandler,
        fieldName: prefix + _ingredients,
      );

  static const _publishDate = 'publishDate';
  String get publishDate => prefix + _publishDate;
  static const _expiryDate = 'expiryDate';
  String get expiryDate => prefix + _expiryDate;
  static const _preparationDuration = 'preparationDuration';
  String get preparationDuration => prefix + _preparationDuration;
  static const _totalDuration = 'totalDuration';
  String get totalDuration => prefix + _totalDuration;
  static const _isPublished = 'isPublished';
  String get isPublished => prefix + _isPublished;
  static const _requiresRobot = 'requiresRobot';
  String get requiresRobot => prefix + _requiresRobot;
  static const _mainApplianceType = 'mainApplianceType';
  String get mainApplianceType => prefix + _mainApplianceType;
  static const _secondaryApplianceType = 'secondaryApplianceType';
  String get secondaryApplianceType => prefix + _secondaryApplianceType;
  static const _tags = 'tags';
  String get tags => prefix + _tags;
  static const _extraTags = 'extraTags';
  String get extraTags => prefix + _extraTags;

  @override
  String toString() => fieldName;
}
