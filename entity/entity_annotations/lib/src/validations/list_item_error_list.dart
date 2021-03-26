import 'error_list.dart';

/// Represents the validation errors, [errorList], of an object [item]
/// that is part of a list, [list] at the index [itemIndex]
class ListItemErrorList {
  /// The error of the object [item]
  final ErrorList errorList;

  /// The index of the [list] to which the [item] belongs to
  final int itemIndex;

  /// The list to which [item] belongs to
  final List list;

  /// The object which the validation errors, [errorList], apply to
  final Object item;

  ListItemErrorList._(this.errorList, this.list, this.item, this.itemIndex);

  factory ListItemErrorList(List list, Object item, ErrorList errorList) {
    var index = list.indexOf(item);
    var ret = ListItemErrorList._(errorList, list, item, index);
    return ret;
  }
}
