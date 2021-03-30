# defaults_provider_annotations and defaults_provider_generator packages usage example

This is an example project that demonstrates the usage of the defaults_provider_annotations and defaults_provider_generator packages.

## Getting started

While this project is an example of a completely setup project, the steps performed to create it are explained below as if the project hadn't been prepared already.

### pubspec.yaml

The first step is to add package defaults_provider_annotations to the dependencies section.

Next, the defaults_provider_generator and build_runner packages are also to be added to the dev_dependencies section.

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
