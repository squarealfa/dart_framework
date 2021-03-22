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



## History and future improvements

This package was initially created when we were considering using MongoDB. We didn't find an easy way to use json_serializable with MongoDBs very specific ObjectId type. This was our initial motivation. Since we were developing our own serializer, and we were trying to integrate it in a much more streamlined way with the rest of our framework, we introduced several improvements over the original idea we started with, namely the ```MapMapper<TEntity>``` class and the extensions.

However, a later decision was to use ArangoDB, rather than MongoDB, and the former does not use a specific type like an ObjectId. Therefore, we no longer really need custom serialization code, but we still want to keep the nice features we added to what json_serializable presents.

A future improvement will be to keep this package, but replace some of its implementation with a dependency to json_serializable, without however introducing any breaking change to whatever code has been using the package. Pull-requests are welcome.