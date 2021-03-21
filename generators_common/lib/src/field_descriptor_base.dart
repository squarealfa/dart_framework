import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

/// Enhanced information over a [FieldElement]
class FieldDescriptorBase {
  final ClassElement classElement;
  final FieldElement fieldElement;

  FieldDescriptorBase(this.classElement, this.fieldElement);

  /// The displayName of the field element.
  String get name => fieldElement.displayName;

  /// Gets a non-nullable value representation of the field.
  ///
  /// When the field is not a nullable field, this will
  /// simply returns the field's name. Otherwise, it will
  /// return the field's name followed by !.
  String get valueName => '$name${isNullable ? '!' : ''}';

  /// Returns the type of the field element
  DartType get fieldElementType => fieldElement.type;

  /// Returns the name of the type of the field element
  String get fieldElementTypeName =>
      fieldElementType.getDisplayString(withNullability: false);

  /// When the field element is a List, returns the type of List element
  DartType? get listParameterType =>
      fieldElementType.isDartCoreList && fieldElementType is ParameterizedType
          ? (fieldElementType as ParameterizedType).typeArguments.first
          : null;

  /// Returns the list element type when the field is a list and
  /// returns the field element when otherwise
  DartType get itemType => listParameterType ?? fieldElementType;

  /// Returns true when the field is a list
  bool get isRepeated => listParameterType != null;

  /// Returns true when the field is an enum
  bool get typeIsEnum => fieldElement.type.element!.kind.name == 'ENUM';

  /// Returns true when the field is a nullable type
  bool get isNullable =>
      fieldElementType.nullabilitySuffix == NullabilitySuffix.question;

  /// Returns the ? character when the field is a nullable type. Otherwise,
  /// returns an empty string
  String get nullSuffix => isNullable ? '?' : '';

  /// Returns an empty string when the field is a nullable, otherwise
  /// returns 'required'
  String get requiredPrefix => isNullable ? '' : ' required ';

  /// When the field element type is a generic, returns the
  /// first type parameter type
  DartType get parameterType {
    var pt = fieldElementType as ParameterizedType;
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

  /// When the field element type is a generic, returns the
  /// firt type parameter type name
  String get parameterTypeName =>
      parameterType.getDisplayString(withNullability: false);

  /// When the field element type is a generic, returns
  /// a value indicating whether the first type parameter is an enum
  bool get parameterTypeIsEnum => parameterType.element!.kind.name == 'ENUM';
}
