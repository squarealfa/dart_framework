import 'list_item_error_list.dart';
import 'validation_error.dart';

/// Validation error applied to properties of List type, composed of
/// multiple errors
class ListPropertyValidation extends ValidationError {
  /// The validation errors of the property. This list is empty when the
  /// property has no error
  final List<ListItemErrorList> listItemErrorLists;

  ListPropertyValidation(
      String fieldName, List<ListItemErrorList> listItemErrorLists)
      : listItemErrorLists = listItemErrorLists
            .where((element) => element.errorList.validationErrors.isNotEmpty)
            .toList(),
        super(fieldName);
}
