/// Repository pattern for NoSQL databases
///
/// The purpose of this package is to define a structure
/// of an interface to access a NoSQL database.
/// The main abstraction it defines is the [Repository] class.
/// The [Repository] class represents a set of operations
/// that are used to access a collection in a database, which
/// include the typical CRUD methods (Create, Read, Update and Delete).
///
/// The [Repository] is abstract. The goal is to create concrete
/// implementations of it, but reference the abstract class throughout
/// the code of the application, therefore abstracting away as much
/// as possible the concrete database engine.

library repository;

export 'src/db_exception.dart';
export 'src/db_principal.dart';
export 'src/errors/not_found.dart';
export 'src/expressions/expressions.dart';
export 'src/orderby.dart';
export 'src/policy/create_policy.dart';
export 'src/policy/delete_policy.dart';
export 'src/policy/entity_permission_policy.dart';
export 'src/policy/permission_policy.dart';
export 'src/policy/search_policy.dart';
export 'src/policy/update_policy.dart';
export 'src/repository.dart';
export 'src/search_criteria.dart';
export 'src/search_result.dart';
