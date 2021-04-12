import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

/// Enhanced information over a [FieldElement]
class MethodDescriptorBase {
  final ClassElement classElement;
  final MethodElement methodElement;

  MethodDescriptorBase(this.classElement, this.methodElement);

  /// The displayName of the field element.
  String get name => methodElement.name;

  /// Returns the type of the field element
  DartType get returnType => methodElement.returnType;

  bool get returnTypeIsFuture =>
      returnType.isDartAsyncFuture || returnType.isDartAsyncFutureOr;

  /// Returns the name of the type of the field element
  String get returnTypeName =>
      returnType.getDisplayString(withNullability: false);

  /// When the field element is a List, returns the type of List element
  DartType? get returnListParameterType =>
      returnType.isDartCoreList && returnType is ParameterizedType
          ? (returnType as ParameterizedType).typeArguments.first
          : null;

  DartType get parameterType => methodElement.parameters.first.type;
  DartType? get parameterListParameterType =>
      parameterType.isDartCoreList && parameterType is ParameterizedType
          ? (parameterType as ParameterizedType).typeArguments.first
          : null;

  /// Returns the list element type when the field is a list and
  /// returns the field element when otherwise
  DartType get itemType => returnListParameterType ?? returnType;
  DartType get parameterItemType => parameterListParameterType ?? parameterType;

  /// Returns true when the field is a list
  bool get isRepeated => returnListParameterType != null;

  /// Returns true when the field is a nullable type
  bool get isNullable =>
      returnType.nullabilitySuffix == NullabilitySuffix.question;

  /// Returns the ? character when the field is a nullable type. Otherwise,
  /// returns an empty string
  String get nullSuffix => isNullable ? '?' : '';

  /// Returns an empty string when the field is a nullable, otherwise
  /// returns 'required'
  String get requiredPrefix => isNullable ? '' : ' required ';

  /// When the field element type is a generic, returns the
  /// first type parameter type
  DartType get returnParameterType {
    var pt = returnType as ParameterizedType;
    var ret = pt.typeArguments[0];
    return ret;
  }

  /// Returns the name of the field using a Pascal Case
  String get pascalName {
    if (name == '') {
      return name;
    }
    return '${name.substring(0, 1).toUpperCase()}${name.substring(1)}';
  }

  /// When the field element type is a generic, returns
  /// a value indicating whether the first type parameter is an enum
  bool get returnParameterTypeIsEnum =>
      returnParameterType.element!.kind.name == 'ENUM';
}
