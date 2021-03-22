# map_mapper_generator

The purpose of this package, alongside its companion map_mapper_annotations package, is to significantly reduce the workload of exposing Dart business model classes to NoSQL database repositories that persist data as Map<String, dynamic> instead of strongly typed objects. 

This project is heavily inspired by the [json_serializable](https://pub.dev/packages/json_serializable) package. However, while the serialization logic is relatively similar, the way it is exposed is different. While the json_serializable packages generates private methods, this package generates subclasses of ```MapMapper<TEntity>``` that have a ```Map<String, dynamic> toMap(TEntity instance)``` method and a ```TEntity fromMap(Map<String, dynamic>) map``` method. 

The purpose behind this approach is to be able to develop generic service handling code that is able to handle any kind of ```TEntity```, serialize those entities and send them to a database, or retrieve them from the database and deserialize them.

More concretely, with this approach, it is easier to develop a generic mixin that handles gRPC requests and takes care of the typical CRUD requests.

Additionally, the generated code also defines class extensions that make it unnecessary to create factory constructors in the classes being serialized.

For instance, if we have a ```Recipe``` class, all we need to do to have it serializable is to add the ```@mapMap``` attribute, without having to type any other method or factory:

```dart
@mapMap
class Recipe {
  final String key;
  final String title;
  final List<Ingredient> ingredients;

  Recipe({
      this.key = '',
      required this.title,
      required this.ingredients,
      });

  // no code is required to be added here to support 
  // serialization
}

```

Instead, because the generated code adds an extension to ```Recipe``` and ```Map<String, dynamic>```, serialization and deserialization is as simple as:

```dart

  final recipe = Recipe(/* initialization params */);

  // this will create a Map<String, dynamic> 
  // with the properties. Note that we didn't
  // actually need to add a toMap() method
  // to recipe, as an extension was created 
  // in recipe.g.dart with that method.
  final recipeMap = recipe.toMap();

  // this will recreate a Recipe.
  // This is also possible because we also
  // added an extension to Map<String, dynamic>
  // that adds the method toRecipe().
  final recipe2 = recipeMap.toRecipe();

```


## Getting started

In order to get started, look at the example project at https://github.com/squarealfa/dart_framework/tree/main/map_mapper/map_mapper_example.