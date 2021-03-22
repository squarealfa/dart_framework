import 'list_item_error_list.dart';
import 'validation_error.dart';

class ListPropertyValidation extends ValidationError {
  final List<ListItemErrorList> listItemErrorLists;

  ListPropertyValidation(
      String fieldName, List<ListItemErrorList> listItemErrorLists)
      : listItemErrorLists = listItemErrorLists
            .where((element) => element.errorList.validationErrors.isNotEmpty)
            .toList(),
        super(fieldName);
}
