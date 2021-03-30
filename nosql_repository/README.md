NoSQL repository pattern

The purpose of this package is to define a structure
of an interface to access a NoSQL database.
The main abstraction it defines is the [Repository] class.
The [Repository] class represents a set of operations
that are used to access a collection in a database, which
include the typical CRUD methods (Create, Read, Update and Delete).

The [Repository] is abstract. The goal is to create concrete 
implementations of it, but reference the abstract class throughout
the code of the application, therefore abstracting away as much 
as possible the concrete database engine.

## Usage

See the example.

## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).