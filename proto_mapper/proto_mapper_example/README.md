# proto_annotations and proto_generator packages usage example

This is an example project that demonstrates the usage of the proto_annotations and proto_generator packages.

## Getting started

While this project is an example of a completely setup project, the steps performed to create it are explained below as if the project hadn't been prepared already.

### pubspec.yaml

The first step is to add package proto_annotations to the dependencies section.

Next, the proto_generator and build_runner packages are also to be added to the dev_dependencies section.

### Annotations

Decorate each class for which a corresponding .proto message is to be generated with a @proto annotation:

```dart
@proto 
class Recipe { ... }
```
This will generate a .proto file, in this example, recipe.proto, that will contain a message that, unless configured otherwise, will have the same name of the class, but prefixed with a G, which in this example is GRecipe:

```proto
...

message GRecipe
{
  ...
}
```

When running the protoc compiler (see below), a corresponding GRecipe dart will be created.

Decorate each class for which mapping code is to be generated with a @mapProto annotation and add a part statement:

```dart
part 'recipe.g.dart';

@proto 
@mapProto
class Recipe { ... }
```

This will create an extension class on Recipe that contains a toProto() function that maps the conversion between Recipe and GRecipe. It will also create an extension on the GRecipe class that maps the conversion between GRecipe and Recipe.


### running the generators

In order to generate the .proto files and the mapping code, at the root of the project, run:

```bash
dart run build_runner build
```

Next, to generate the serialization code from the .proto files, ensure that the lib/src/grpc directory exists and run:

```bash
protoc --dart_out=grpc:lib/src/grpc/ -Ilib/src/ ./lib/src/*.proto
```


### customizing code generation

There are other annotations that can be used to further control the code generation process.

Furthermore, defaults can be tweeked by using the included build.yaml file.


## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).
