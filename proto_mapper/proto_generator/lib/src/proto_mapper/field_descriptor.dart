import 'package:analyzer/dart/element/element.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

class FieldDescriptor extends FieldDescriptorBase {
  final MapProtoBase protoMapperAnnotation;
  final ProtoField? protoFieldAnnotation;
  final ProtoIgnore? protoIgnoreAnnotation;

  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement,
    this.protoMapperAnnotation, {
    this.protoFieldAnnotation,
    this.protoIgnoreAnnotation,
  }) : super(classElement, fieldElement) {}

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
    MapProtoBase mapProtoBase,
  ) {
    final protoFieldAnnotation = _getProtoFieldAnnotation(fieldElement);
    final protoIgnoreAnnotation = _getProtoIgnoreAnnotation(fieldElement);

    return FieldDescriptor._(
      classElement,
      fieldElement,
      mapProtoBase,
      protoFieldAnnotation: protoFieldAnnotation,
      protoIgnoreAnnotation: protoIgnoreAnnotation,
    );
  }

  String get prefix => protoMapperAnnotation.prefix ?? '';

  bool get isRepeated => listParameterType != null;
  bool get _hasProtoIgnore => protoIgnoreAnnotation != null;
  bool get _hasProtoField => protoFieldAnnotation != null;

  String get protoFieldName => protoFieldAnnotation?.name ?? name;

  bool get isProtoIncluded =>
      !_hasProtoIgnore &&
      (protoMapperAnnotation.includeFieldsByDefault || _hasProtoField);

  bool get typeHasMapProtoAnnotation {
    var annotation = TypeChecker.fromRuntime(MapProtoBase)
        .firstAnnotationOf(this.fieldElement.type.element!);
    return annotation != null;
  }

  bool get parameterTypeIsEnum => parameterType.element!.kind.name == "ENUM";
}

const _protoFieldChecker = TypeChecker.fromRuntime(ProtoField);

ProtoField? _getProtoFieldAnnotation(FieldElement fieldElement) {
  var annotation = _protoFieldChecker.getFieldAnnotation(fieldElement);
  if (annotation == null) return null;
  var name = annotation.getField('name')!.toStringValue();
  var ret = ProtoField(name: name);
  return ret;
}

const _protoIgnoreChecker = TypeChecker.fromRuntime(ProtoIgnore);
ProtoIgnore? _getProtoIgnoreAnnotation(FieldElement fieldElement) =>
    _protoIgnoreChecker.getFieldAnnotation(fieldElement) == null
        ? null
        : ProtoIgnore();
