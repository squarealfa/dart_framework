import 'dart:async';

import 'package:nosql_repository/nosql_repository.dart';
import 'package:nosql_repository/src/transaction_options.dart';

/// Defines data access methods to a specific
/// database collection.
///
/// The [TEntity] type parameter is
/// mostly a convenience parameter
/// to facilitate the usage of
/// dependency-injection containers. If
/// you are not using a DI container or
/// your DI container does not use
/// type-parameters, you can safely ignore it.
abstract class Repository<TEntity> {
  // default authorization policy for creation operations
  CreatePolicy get createPolicy;

  /// default authorization policy for search operations
  SearchPolicy get searchPolicy;

  /// default authorization policy for update operations
  UpdatePolicy get updatePolicy;

  /// default authorization policy for delete operations
  DeletePolicy get deletePolicy;

  /// Inserts the map as a new entity in the database collection.
  ///
  /// This method expects a [principal] parameter, which
  /// identifies the user performing the request. Implementations
  /// may add metadata to the entity based on that principal,
  /// like for instance a key identifying a tenant and logging.
  ///
  /// If a non-empty value is passed to the [permission] parameter,
  /// the implementation of this method is expected to validate
  /// if the user represented by the [principal] does have the
  /// permission before actually inserting the entity. Otherwise,
  /// an error is thrown.
  ///
  /// It is possible that the database engine makes changes
  /// to the inserted entity, like for instance adding an
  /// automatically incremented key (primary key) to the entity.
  ///
  /// Implementations of this method are required to
  /// return the updated entity.
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> map,
    DbPrincipal principal, {
    CreatePolicy? createPolicy,
    Transaction? transaction,
  });

  /// Deletes the entity from the collection identified by the [key] parameter.
  ///
  /// This method expects a [principal] parameter, which
  /// identifies the user performing the request. Implementations
  /// are advised to confirm if the entity being deleted belongs to
  /// a tenant related to the [principal].
  ///
  /// If a non-empty value is passed to the [permission] parameter,
  /// the implementation of this method is expected to validate
  /// if the user represented by the [principal] does have the
  /// permission before actually inserting the entity. Otherwise,
  /// an error is thrown.
  Future delete(
    String key,
    DbPrincipal principal, {
    DeletePolicy? deletePolicy,
    Transaction? transaction,
  });

  /// Update an entity in the collection contained in the [map] parameter.
  ///
  /// This method expects a [principal] parameter, which
  /// identifies the user performing the request. Implementations
  /// are advised to confirm if the entity being updated belongs to
  /// a tenant related to the [principal].
  ///
  /// If a non-empty value is passed to the [permission] parameter,
  /// the implementation of this method is expected to validate
  /// if the user represented by the [principal] does have the
  /// permission before actually updating the entity. Otherwise,
  /// an error is thrown.
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> map,
    DbPrincipal principal, {
    UpdatePolicy? updatePolicy,
    Transaction? transaction,
  });

  /// Retrieves an entity from the collection identified by the [key] parameter.
  ///
  /// This method expects a [principal] parameter, which
  /// identifies the user performing the request. Implementations
  /// are advised to confirm if the entity being returned belongs to
  /// a tenant related to the [principal].
  ///
  /// If a non-empty value is passed to the [permission] parameter,
  /// the implementation of this method is expected to validate
  /// if the user represented by the [principal] does have the
  /// permission before actually returning the entity. Otherwise,
  /// an error is thrown.
  Future<Map<String, dynamic>> get(
    String key,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  });

  /// Gets all the entities from the collection identified by the [key]
  /// parameter.
  /// Use this method only with collections where the number of elements in
  /// the collection (per tenant) is guaranteed to be very limited.
  ///
  /// This method expects a [principal] parameter, which
  /// identifies the user performing the request. Implementations
  /// are advised to filter the returned elements by the tenant of the
  /// [principal].
  ///
  /// If a non-empty value is passed to the [permission] parameter,
  /// the implementation of this method is expected to validate
  /// if the user represented by the [principal] does have the
  /// permission before actually returning the elements. Otherwise,
  /// an error is thrown.
  Future<Stream<Map<String, dynamic>>> getAllToStream(
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  });

  Future<List<Map<String, dynamic>>> getAllToList(
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  }) async {
    final stream = await getAllToStream(
      principal,
      searchPolicy: searchPolicy,
      transaction: transaction,
    );
    final list = await stream.toList();
    return list;
  }

  /// Searches entities according to [criteria],
  /// returning a page of entities and the count
  /// of total entities that fit the given constraints.
  ///
  /// Implementations should filter the search results
  /// limiting them to entities belonging to
  /// the tenant of the [principal].
  ///
  /// By default, this method will search
  /// all entities in the collection owned by
  /// the [principal], except when the
  /// [permission] parameter is given.
  /// When the [permission] parameter has a
  /// non-empty argument and the user identified
  /// by the [principal] has that permission,
  /// then all the entities in the collection
  /// belonging to the tenant within the criteria
  /// defined by the [criteria], regardless of
  /// their owner within the tenant.
  Future<SearchResult> searchWithCount(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  });

  /// Searches entities according to [criteria] and returns the
  /// total count of entities fitting the constraints.
  ///
  /// Implementations should filter the search results
  /// limiting them to entities belonging to
  /// the tenant of the [principal].
  ///
  /// By default, this method will search
  /// all entities in the collection owned by
  /// the [principal], except when the
  /// [permission] parameter is given.
  /// When the [permission] parameter has a
  /// non-empty argument and the user identified
  /// by the [principal] has that permission,
  /// then all the entities in the collection
  /// belonging to the tenant within the criteria
  /// defined by the [criteria], regardless of
  /// their owner within the tenant.
  Future<int> count(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  });

  /// Searches entities according to [criteria],
  /// returning all the entities that fit the constraints.
  ///
  /// Implementations should filter the search results
  /// limiting them to entities belonging to
  /// the tenant of the [principal].
  ///
  /// By default, this method will search
  /// all entities in the collection owned by
  /// the [principal], except when the
  /// [permission] parameter is given.
  /// When the [permission] parameter has a
  /// non-empty argument and the user identified
  /// by the [principal] has that permission,
  /// then all the entities in the collection
  /// belonging to the tenant within the criteria
  /// defined by the [criteria], regardless of
  /// their owner within the tenant.
  Future<Stream<Map<String, dynamic>>> searchToStream(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  });

  Future<List<Map<String, dynamic>>> searchToList(
    SearchCriteria criteria,
    DbPrincipal principal, {
    SearchPolicy? searchPolicy,
    Transaction? transaction,
  }) async =>
      (await searchToStream(
        criteria,
        principal,
        searchPolicy: searchPolicy,
        transaction: transaction,
      ))
          .toList();

  Future<Transaction> beginTransaction(TransactionOptions options);
  Future commitTransaction(Transaction transaction);
  Future abortTransaction(Transaction transaction);
}
