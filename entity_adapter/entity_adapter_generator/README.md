Generates a facade to several SquareAlfa framework services that are required to expose PODOs via gRPC services.

## EntityAdapted

This package creates the concept of an *adapted entity*. An adapted entity is an a [PODO](https://github.com/squarealfa/dart_framework#podos) that is augmented by several code generators to expose the required features so that it can be served by a gRPC service and persisted into a NoSQL database.

The purpose is to create a very practical way to combine the services of the following code-generators into one, and expose those services into a simple facade class that can be registered with a DI container (see more about [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework)):
- [map_mapper_generator](https://pub.dev/packages/map_mapper_generator)
- [proto_generator](https://pub.dev/packages/proto_generator)
- [defaults_provider_generator](https://pub.dev/packages/defaults_provider_generator)
- [squarealfa_entity_generator](https://pub.dev/packages/squarealfa_entity_generator)

This package provides a ```EntityAdapted``` annotation that replaces all the annotations required to use all the services provided by the above packages. For instance, without the ```EntityAdapted``` annotation, we would need to add several annotations to a [PODO](https://github.com/squarealfa/dart_framework#podos) to use all the services, as examplified below:

```dart
/// Thank goodness we have EntityAdapted, 
/// so we don't need to add all these 
/// annotations to each PODO
@MapMap()
@Proto()
@MapProto()
@DefaultsProvider()
@Validatable()
@BuildBuilder()
@CopyWith()
class Recipe extends Entity {
    /// ... content
}
```

With ```EntityAdapted```, we can replace all the above annotations with a single annotation:

```dart
@EntityAdapted()
class Recipe extends Entity {
    /// ... content
}
```

## EntityAdapter

The [EntityAdapted] class has an added property, [rootEntityType]
that drives further code generation when [EntityAdapted] is
applied to subclasses of [rootEntityType], like an [EntityAdapter]
and an [EntityPermissions] subclass.

## Getting started

### A few more concepts first

Before beginning, let's define the concept of a root object. We are 
considering a root object as an object that is the root of a document
to be persisted in a collection database.

Let's use an example to better clarify the concept. In our example,
our database has a collection of people (in more abstract terms,
we have a repository of people). Each person will have a set of 
personal assets, which we will store as properties of the person. 
We will not have an independent collection of assets, as we are not
considering each asset as an independent object with its own 
life-cycle. In this example, the class  ```Person``` would be
considered a root object. The class ```Asset``` would not be
considered a root object.

Root objects deserve some special treatment. For one, they
are the objects to which we will apply the [repository pattern](https://pub.dev/packages/nosql_repository). It is also for root objects that we will
create services (we are assuming gRPC, but the concept can be expanded to
REST). Additionally, it is for root objects that we will require 
permissions for CRUD operations. Finally, it also makes sense to attach to root objects tenancy-filters, revision logs and share permissions. All in all, there's a lot of extra aspects going on with those objects.

## Now, really getting started

Let's begin by assuming that we have a ```Person``` class that is supposed to become a root object and an ```Asset``` class that is not:

```dart
class Person {
  final List<Asset> assets;

  final String name;

  Person({
    required this.assets,
    required this.name,
  });
}
```
```dart
class Asset {
  final String description;
  final Decimal value;

  Asset({
    required this.description,
    required this.value,
  });
}
```

Create a class that will represent all root objects in your system (see the concept in the previous section). For instance, we can have a class called ```Entity``` that represents all root objects:

```dart
/// we could add extra features, like CRUD auditing 
/// information, shares, and so on.
class Entity {}
```

For later simplicity, create a constant that represents an ```EntityAdapted``` with the type ```Entity```:

```dart
const entity = EntityAdapted(rootEntityType: Entity);
```

Since, ```Person``` is to become a root object, change the class so that it extends from ```Entity```:

```dart
class Person extends Entity {
    /// existing implementation
    /// ....
}
```

Next, regardless of being root objects or not, simply apply ```EntityAdapted(rootEntityType: Entity)``` as an annotation to all the classes we want to use as PODOs that will represent business concepts. Instead of typing the whole instantiation, we can simply apply the const we created above, ```entity```:

```dart 
/// since there will be generated code, don't forget
/// the part declaration
part 'person.g.dart';

@entity
class Person extends Entity {
    /// existing implementation
    /// ....
}

```

```dart 
/// since there will be generated code, don't forget
/// the part declaration
part 'asset.g.dart';

@entity
class Asset {
    /// existing implementation
    /// ....
}
```

Note that you don't need to adapt the annotation to whether the object is a root object or not. It is always applied the same way. 

Finally, all you need to do is generate the code by running, on a shell:

```bash
# run this framework's code generators, driven by the @entity annotation
dart run build_runner build

# then we generate the protocol buffer serialization classes
# see https://pub.dev/packages/proto_generator and 
# https://github.com/squarealfa/dart_framework/tree/main/proto_mapper/proto_mapper_example
rm -rf ./lib/grpc/
mkdir ./lib/grpc
protoc --dart_out=grpc:lib/grpc/ -Ilib/src ./lib/src/*.proto
```

After running the previous commands, add all the missing imports and voilá, you have full-blown entities ready to be used in gRPC communications, ready to be persisted into a NoSQL database, ready to be validated, and so on.