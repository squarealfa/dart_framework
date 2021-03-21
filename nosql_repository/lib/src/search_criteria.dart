import 'expressions/expressions.dart';
import 'orderby.dart';
import 'return_field.dart';

/// Represents a search criteria
///
/// A search criteria contains all the parameters
/// required to perform a search, which include
/// the conditions, which fields to be returned,
/// which field to be ordered by, and paging
/// criteria, namely how many records to skip
/// from the total results and how many to take.
class SearchCriteria {
  /// Business filter of the conditions to be applied to the search
  final List<Expression> searchConditions;

  /// Projection of fields to be returned.
  ///
  /// If left null, full documents
  /// are to be returned.
  final List<ReturnField> returnFields;

  /// Sorting criteria.
  ///
  /// If left null, no specific sort is to be applied
  final List<OrderBy> orderByFields;

  /// How many documents to skip.
  ///
  /// Can be left null for no skipping to take place,
  /// but the number of results is still dependent on the
  /// [take] property.

  /// If both this property and [take] are null,
  /// all documents fitting the [searchConditions]
  /// (and limited by tenancy and permissions) are
  /// returned.
  final int? skip;

  /// How many documents to be taken.
  ///
  /// Can be left null so that all the documents
  /// since the [skip] are returned.
  ///
  /// If both [skip] and this property are null,
  /// all documents fitting the [searchConditions]
  /// (and limited by tenancy and permissions) are
  /// returned.
  final int? take;

  const SearchCriteria({
    this.searchConditions = const [],
    this.returnFields = const [],
    this.orderByFields = const [],
    this.skip,
    this.take,
  });
}
