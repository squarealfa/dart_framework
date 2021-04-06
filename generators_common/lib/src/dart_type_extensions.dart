import 'package:analyzer/dart/element/type.dart';

extension TypeExtensions on DartType {
  DartType get finalType {
    var type = this;
    while (type is ParameterizedType && type.typeArguments.isNotEmpty) {
      type = type.typeArguments.first;
    }
    return type;
  }

  bool get isList {
    var type = this;
    while (type is ParameterizedType && type.typeArguments.isNotEmpty) {
      if (type.isDartCoreList) {
        return true;
      }
      type = type.typeArguments.first;
    }
    return false;
  }
}
