// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// DefaultsProviderGenerator
// **************************************************************************

class RecipeDefaultsProviderBase {
  Recipe createWithDefaults() {
    return Recipe(
      key: key,
      title: title,
      ingredients: ingredients,
      numPosts: numPosts,
      doubleNumPosts: doubleNumPosts,
      decimalNumPosts: decimalNumPosts,
      mainIngredient: mainIngredient,
      category: category,
    );
  }

  String get key => '';
  String get title => '';
  List<Ingredient> get ingredients => [];
  int get numPosts => 0;
  double get doubleNumPosts => throw UnimplementedError();
  Decimal get decimalNumPosts => Decimal.zero;
  Ingredient get mainIngredient =>
      IngredientDefaultsProvider().createWithDefaults();
  Category get category => throw UnimplementedError();
}
