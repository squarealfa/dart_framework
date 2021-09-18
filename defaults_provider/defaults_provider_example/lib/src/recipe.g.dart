// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// DefaultsProviderGenerator
// **************************************************************************

abstract class $RecipeDefaultsProviderBase {
  const $RecipeDefaultsProviderBase();

  Recipe createWithDefaults({
    String? key,
    String? title,
    List<Ingredient>? ingredients,
    int? numPosts,
    double? doubleNumPosts,
    Decimal? decimalNumPosts,
    Ingredient? mainIngredient,
    Category? category,
  }) {
    return Recipe(
      key: key ?? this.key,
      title: title ?? this.title,
      ingredients: ingredients ?? this.ingredients,
      numPosts: numPosts ?? this.numPosts,
      doubleNumPosts: doubleNumPosts ?? this.doubleNumPosts,
      decimalNumPosts: decimalNumPosts ?? this.decimalNumPosts,
      mainIngredient: mainIngredient ?? this.mainIngredient,
      category: category ?? this.category,
    );
  }

  String get key => '';
  String get title => '';
  List<Ingredient> get ingredients => const [];
  int get numPosts => 0;
  double get doubleNumPosts => 0;
  Decimal get decimalNumPosts => Decimal.zero;
  Ingredient get mainIngredient =>
      $IngredientDefaultsProvider().createWithDefaults();
  Category get category;
}
