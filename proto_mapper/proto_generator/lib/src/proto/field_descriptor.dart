import 'package:analyzer/dart/element/element.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

class FieldDescriptor extends FieldDescriptorBase {
  final Proto protoAnnotation;
  final ProtoField? protoFieldAnnotation;
  final ProtoIgnore? protoIgnoreAnnotation;

  FieldDescriptor._(
    ClassElement classElement,
    FieldElement fieldElement,
    this.protoAnnotation, {
    this.protoFieldAnnotation,
    this.protoIgnoreAnnotation,
  }) : super(classElement, fieldElement);

  factory FieldDescriptor.fromFieldElement(
    ClassElement classElement,
    FieldElement fieldElement,
    Proto protoBase,
  ) {
    final protoFieldAnnotation = _getProtoFieldAnnotation(fieldElement);
    final protoIgnoreAnnotation = _getProtoIgnoreAnnotation(fieldElement);

    return FieldDescriptor._(
      classElement,
      fieldElement,
      protoBase,
      protoFieldAnnotation: protoFieldAnnotation,
      protoIgnoreAnnotation: protoIgnoreAnnotation,
    );
  }

  String get prefix => protoAnnotation.prefix ?? '';

  @override
  bool get isRepeated => listParameterType != null || setParameterType != null;
  bool get _hasProtoIgnore => protoIgnoreAnnotation != null;
  bool get _hasProtoField => protoFieldAnnotation != null;

  String get protoFieldName => protoFieldAnnotation?.name ?? name;

  bool get isProtoIncluded =>
      !_hasProtoIgnore &&
      (protoAnnotation.includeFieldsByDefault || _hasProtoField);

  bool get typeHasProtoAnnotation {
    var annotation = TypeChecker.fromRuntime(MapProto)
        .firstAnnotationOf(fieldElement.type.element!);
    return annotation != null;
  }

  @override
  bool get parameterTypeIsEnum => parameterType.element!.kind.name == 'ENUM';
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
