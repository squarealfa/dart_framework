import 'package:analyzer/dart/element/element.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';
import 'package:source_gen/source_gen.dart';

class FieldDescriptor extends FieldDescriptorBase {
  final MapMap mapMapAnnotation;

  final MapField? mapFieldAnnotation;
  final MapIgnore? mapIgnoreAnnotation;

  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement,
    this.mapMapAnnotation, {
    this.mapFieldAnnotation,
    this.mapIgnoreAnnotation,
  }) : super(classElement, fieldElement);

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
    MapMap mapEntityAnnotation,
  ) {
    final mapFieldAnnotation = _getMapField(fieldElement);
    final mapIgnoreAnnotation = _getMapIgnore(fieldElement);

    return FieldDescriptor._(
      classElement,
      fieldElement,
      mapEntityAnnotation,
      mapFieldAnnotation: mapFieldAnnotation,
      mapIgnoreAnnotation: mapIgnoreAnnotation,
    );
  }

  bool get _hasMapIgnore => mapIgnoreAnnotation != null;
  bool get _hasMapField => mapFieldAnnotation != null;

  bool get isMapIncluded =>
      !_hasMapIgnore &&
      (mapMapAnnotation.includeFieldsByDefault || _hasMapField);

  String get mapName =>
      mapFieldAnnotation?.name ??
      (fieldElement.name == 'id' ? '_id' : fieldElement.name);

  bool get typeHasMapMapAnnotation {
    var annotation = TypeChecker.fromRuntime(MapMap)
        .firstAnnotationOf(fieldElement.type.element!);
    return annotation != null;
  }

  bool get parameterTypeHasMapMapAnnotation {
    var annotation = TypeChecker.fromRuntime(MapMap)
        .firstAnnotationOf(parameterType.element!);
    return annotation != null;
  }
}

MapField? _getMapField(FieldElement fieldElement) {
  var reader =
      TypeChecker.fromRuntime(MapField).firstAnnotationOf(fieldElement);
  if (reader == null) return null;
  var ret = MapField(name: reader.getField('name')!.toStringValue());
  return ret;
}

MapIgnore? _getMapIgnore(FieldElement fieldElement) {
  var reader =
      TypeChecker.fromRuntime(MapIgnore).firstAnnotationOf(fieldElement);
  if (reader == null) return null;
  return MapIgnore();
}
