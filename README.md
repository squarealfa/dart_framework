# SquareAlfa Dart Framework
This repository contains SquareAlfa's Dart Framework. 

## Introduction

###  <a name="podos"></a>PODOs

Throughout this document, there are references to PODOs. Just like a POJO is a Plain-Old-Java-Object, a POCO is a Plain-Old-C#-Object, we are referring to a PODO as a Plain-Old-Dart-Object. A PODO is a Dart class that has no layer-specific features, except for some annotations. A PODO will represent a business concept and focus itself almost totally on that business object. A PODO might represent a real-world concept like a person, a contract, a vehicle, and so on. 

A PODO, however, will, for instance, not have code to serialize itself to JSON or back (except annotations that configure how that serialization is to be performed). The absolute requirement a PODO has is that is must work just as well in Flutter as in server-side Dart. Therefore, it can never assume anything about the environment it is instantiated in.

So, if a PODO is so bare-bones and contains almost only business logic code, how do we add the remaining aspects to the applications? This framework is betting heavily in code generation. The only exception to the rule of only having business-specific features represented in the PODOs are the annotations that drive that code generation. For instance, if we want to serialize a PODO so that we can store them in a database, we will only add an annotation to the class (and optionally to any property that needs special treatment). A code generator will pick all the PODOs that have that annotation and will generate another class for each of the PODOs that does that serialization. 
We have several code-generators that add features, like automatically generated validation code, builders, and so on. In some instances, the generated code will be an entirely separate class. In other instances it will be an extension.

### Framework Concept

There is one single driving purpose behind this framework, or rather, by this cohesive, yet loosely coupled collection of packages. The purpose is to enable us to use Dart as a full-stack language with as less busy work as possible. Manually typed boilerplate code fits perfectly into our definition of busy work.

Since Flutter is already an amazing framework, our focus with this framework is to:

- Make it really easy to use Dart on the server.

- Make it even easier to share code between the server and the client. This means mainly two things:

    - Sharing the classes that constitute the business model. We absolutely hate typing a model to represent a concept that needs to be stored in a database and typing it all over again in a different language so we can present the concept to the user.

    - Sharing validation logic. Validation should be done at the client for usability, and must be done at the server for security. Having to type the rules only once is, however, a time saver.

This framework is not trying to be very opinionated. It is based, however, on assumptions. If your needs do not fit the existing assumptions, you are free to create an issue and we will consider the improvement idea. Even better, after submitting an issue, you can submit a pull request. Moreover, you are not required to use the whole framework as a single monolithic entity. We tried to design the framework so its users could cherry-pick the packages they need.

The assumptions are the following:

- Communications between client and server are done mainly using gRPC. This means that at the time of this writing, we do not care about REST.

- Data is persisted to a NoSQL database. If you need to persist to a RDBMS, bring your own ORM. At this moment, we are using ArangoDB, but we are using the repository pattern, with a driver to the concrete database server.

- All [PODOs](#podos) are immutable objects and all properties are auto-initialized through constructor named parameters. This isn't a principal. While we did some effort to support non immutable objects and we have absolutely no objection to other forms of initialization, the simple fact is that we focused on that approach and all our tests are assuming this. You are free to try the framework assuming otherwise, and we would be delighted to receive pull requests that are needed to make that happen, along with unit tests. In fact, we would be delighted to receive pull requests containing only unit tests that prove that this assumption is no longer needed.

### Nice Features

This framework does offer a few nice features:
- Multi-tenancy out of the box, with all tenants sharing the same database.
- Database access using the repository pattern is filtered by tenant and user permissions.
- Logging of CRUD operations.


### Null-Safety

Strictly all packages are null-safe. One of the databases we would like to support in the future is MongoDB, and it is our intention to do so whenever the mongo_dart package is migrated to null-safety.



### Packages

You may not want the entire feature set, but to cherry-pick the features you will be using. The packages that constitute this framework are the following:

| Package | Description |
|---------|-------------|
|[nosql_repository](https://pub.dev/packages/nosql_repository)|Creates an abstract repository that has as its only assumption that the underlying database is a NoSQL database (document-oriented).|Server|
|[arango_driver](https://pub.dev/packages/arango_driver)|Type-safe and null-safe ArangoDB access driver.|Server|
|[arangodb_repository](https://pub.dev/packages/arangodb_repository)|Implementation of the [nosql_repository](https://pub.dev/packages/nosql_repository) package that uses the [arango_driver](https://pub.dev/packages/arango_driver) package to use ArangoDB with the repository pattern.|
|[squarealfa_security](https://pub.dev/packages/squarealfa_security)|Provides security features. Current version does basic JWT token handling.|
|[map_mapper_annotations](https://pub.dev/packages/map_mapper_annotations) and [map_mapper_generator](https://pub.dev/packages/map_mapper_generator)|Performs the mapping between [PODOs](#podos) and Map<String, dynamic> to be stored in NoSQL databases.|Full-stack|
|[defaults_provider_annotations](https://pub.dev/packages/defaults_provider_annotations) and [defaults_provider_generator](https://pub.dev/packages/defaults_provider_generator)|Generates classes that provide default values for [PODO](#podos) instantiation. It's main purpose is to allow for database soft-migrations.|
|[proto_annotations](https://pub.dev/packages/proto_annotations) and [proto_generator](https://pub.dev/packages/proto_generator)|Handles the relation between [PODOs](#podos) and protocol buffers. Has two main features. The first, is that it generates protocol buffer files (.proto), which are expected to be [compiled](https://grpc.io/docs/languages/dart/quickstart/) to Dart protocol buffer classes that handle all the serialization. The second is that it generates code that maps between the [PODOs](#podos) and the compiled protocol buffer Dart classes.|
|[squarealfa_entity_annotations](https://pub.dev/packages/squarealfa_entity_annotations) and [squarealfa_entity_generator](https://pub.dev/packages/squarealfa_entity_generator)|Adds features to [PODOs](#podos) like validation, builders and an extension to provide a ```copyWith``` method.|
|[squarealfa_entity_adapter](https://pub.dev/packages/squarealfa_entity_adapter) and [squarealfa_entity_adapter_generator](https://pub.dev/packages/squarealfa_entity_adapter_generator/admin)|Provides the annotations and a facade to several SquareAlfa framework services that are required to expose PODOs via gRPC services. These packages are a substitute for all other code-generation packages.|