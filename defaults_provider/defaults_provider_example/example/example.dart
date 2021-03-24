import 'package:defaults_provider_example/src/recipe.dart';

void main(List<String> args) {
  var defaultsProvider = RecipeDefaultsProvider();

  final recipe = defaultsProvider.createWithDefaults();
  print(recipe.title);
}
