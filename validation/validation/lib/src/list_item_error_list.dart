import 'error_list.dart';

class ListItemErrorList {
  final ErrorList errorList;
  final int itemIndex;
  final List list;
  final Object item;

  ListItemErrorList._(this.errorList, this.list, this.item, this.itemIndex);

  factory ListItemErrorList(List list, Object item, ErrorList errorList) {
    var index = list.indexOf(item);
    var ret = ListItemErrorList._(errorList, list, item, index);
    return ret;
  }
}
