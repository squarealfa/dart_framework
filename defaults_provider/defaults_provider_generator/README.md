The purpose of this package is to generate defaults providers. A defaults provider is a class that provides the defaults values for properties of another class to be instantiated when there is a possibility that there are not values for all of the non-nullable properties.

One of the use-cases of a defaults provider is to use it as a way to create soft migrations for NoSQL databases. Nothing better than a concrete example to explain the concept. Let's assume we have the following class:

```dart 
  class Recipe
  {
    final String title;

    Recipe({
      required this.title,
    })
  }
```

Now, let's assume we serialized an instance of that class into JSON and stored that JSON in a document database. The JSON would look like the following:

```json
{
  'title': 'Scrambled eggs'
}
````

To read from the database, all we need to do is parse the JSON and feed each of the properties in each of the named parameters in the constructor. The problem is when we try to evolve the class. Let's say, for instance, that we add a new property, ```author```:

```dart 
  class Recipe
  {
    final String title;
    final String author;

    Recipe({
      required this.title,
      required this.author,
    })
  }
```

New objects will not be a problem. The problem is what do we do with the existing documents in the database, that still don't have an ```author``` property.

One way of getting around this problem is database migrations. Whenever we add a new non-nullable property to an object that is meant to be stored in a database, we go over all the documents in the collection that represents that class of objects and update the stored JSON objects with a new value defined by the developer.

An alternative way is to use a softer approach. We can leave all documents in the database as they are, but only worry about the missing JSON properties when reading from the database. It is in that moment that we will then use a defaults provider to actually instantiate the object, filling in properties with defaults values whenever there is no corresponding value in the JSON document.


### pubspec.yaml

The first step is to add package defaults_provider_annotations to the dependencies section.

Next, the defaults_provider_generator and build_runner packages are also to be added to the dev_dependencies section.

## Getting started

The best way to get started is by looking at the example project at https://github.com/squarealfa/dart_framework/tree/main/defaults_provider/defaults_provider_example.

### Annotations

Decorate each class for which mapping code is to be generated with a @defaultsProvider annotation and add a part statement, if not already present:

```dart
part 'recipe.g.dart';

@defaultsProvider
class Recipe { ... }
```

This will create a new class with the same name as the class to which is applied, suffixed with DefaultsProvider. In the example above, the new class will be named ```RecipeDefaultsProvider```. The defaults provider class has a property with a getter for each of the Recipe's properties that are not nullable, containing a default value for that property.

The automatic defaults are:

|Type|Default|
|----|-------|
|String|''   |
|int|0|
|double|0.0|
|Decimal|Decimal.zero|
|class annotated with @defaultsProvider|call to createWithDefaults of that provider|
|class without @defaultsProvider annotation|throw UnimplementedError()|
|any other type|throw UnimplementedError()|

Every defaults provider class has a createWithDefaults method that will create an 
instance of the class to which the annotation is applied, using all of the default values.

### running the generators

In order to generate the mapping code, at the root of the project, run:

```bash
dart run build_runner build
```

### customizing code generation

The annotation has an option, createDefaultsProviderBaseClass, that when set to true,
will generate a defaults class with the same content, but with an extra suffix, ```Base``` added to its name.

For instance:

```dart
part 'recipe.g.dart';

@DefaultsProvider(createDefaultsProviderBaseClass: true)
class Recipe { ... }
```

Will generate:

```dart

class RecipeDefaultsProviderBase { ... }

```

This allows you to create a subclass with your own overrides. As an example, the following code could be manually typed:

```dart
class RecipeDefaults extends RecipeDefaultsProviderBase
{
      @override
  Category get category => Category(title: 'my category');
}
```


## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).
