import 'package:analyzer/dart/element/element.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

class MethodDescriptor extends MethodDescriptorBase {
  final MapProtoServices protoServicesAnnotation;
  final ProtoIgnore? protoIgnoreAnnotation;

  MethodDescriptor._(
    ClassElement classElement,
    MethodElement methodElement,
    this.protoServicesAnnotation, {
    this.protoIgnoreAnnotation,
  }) : super(classElement, methodElement);

  factory MethodDescriptor.fromMethodElement(
    ClassElement classElement,
    MethodElement methodElement,
    MapProtoServices protoServicesAnnotation,
  ) {
    final protoIgnoreAnnotation = _getProtoIgnoreAnnotation(methodElement);

    return MethodDescriptor._(
      classElement,
      methodElement,
      protoServicesAnnotation,
      protoIgnoreAnnotation: protoIgnoreAnnotation,
    );
  }

  String get prefix => protoServicesAnnotation.prefix ?? '';

  @override
  bool get isRepeated => returnListParameterType != null;
  bool get _hasProtoIgnore => protoIgnoreAnnotation != null;

  bool get isProtoIncluded => !_hasProtoIgnore;

  bool get typeHasProtoAnnotation {
    var annotation = TypeChecker.fromRuntime(MapProto)
        .firstAnnotationOf(methodElement.type.aliasElement!);
    return annotation != null;
  }

  @override
  bool get returnParameterTypeIsEnum =>
      returnParameterType.element!.kind.name == 'ENUM';
}

const _protoIgnoreChecker = TypeChecker.fromRuntime(ProtoIgnore);
ProtoIgnore? _getProtoIgnoreAnnotation(MethodElement methodElement) =>
    _protoIgnoreChecker.getMethodAnnotation(methodElement) == null
        ? null
        : ProtoIgnore();
