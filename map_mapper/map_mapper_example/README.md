# map_mapper_annotations and map_mapper_generator packages usage example

This is an example project that demonstrates the usage of the map_mapper_annotations and map_mapper_generator packages.

## Getting started

While this project is an example of a completely setup project, the steps performed to create it are explained below as if the project hadn't been prepared already.

### pubspec.yaml

The first step is to add package map_mapper_annotations to the dependencies section.

Next, the map_mapper_generator and build_runner packages are also to be added to the dev_dependencies section.

### Annotations


Decorate each class for which mapping code is to be generated with a @mapMap annotation and add a part statement, if not already present:

```dart
part 'recipe.g.dart';

@mapMap
class Recipe { ... }
```

This will create an extension class on Recipe that contains a toMap() function that maps the conversion between Recipe and Map<String, dynamic>. It will also create an extension on the Map<String, dynamic> type-parametrized class that maps the conversion between instances of that class and Recipe.


### running the generators

In order to generate the mapping code, at the root of the project, run:

```bash
dart run build_runner build
```

### customizing code generation

There are other annotations that can be used to further control the code generation process.


## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).
