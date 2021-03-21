// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class ComponentProtoMapper implements ProtoMapper<Component, GComponent> {
  static final ComponentProtoMapper _singleton = ComponentProtoMapper._();

  ComponentProtoMapper._();
  factory ComponentProtoMapper() => _singleton;

  @override
  Component fromProto(GComponent proto) => _$ComponentFromProto(proto);

  @override
  GComponent toProto(Component entity) => _$ComponentToProto(entity);

  Component fromJson(String json) =>
      _$ComponentFromProto(GComponent.fromJson(json));
  String toJson(Component entity) => _$ComponentToProto(entity).writeToJson();
}

GComponent _$ComponentToProto(Component instance) {
  var proto = GComponent();

  proto.description = instance.description;

  return proto;
}

Component _$ComponentFromProto(GComponent instance) => Component(
      description: instance.description,
    );

extension ComponentProtoExtension on Component {
  GComponent toProto() => _$ComponentToProto(this);
  String toJson() => _$ComponentToProto(this).writeToJson();

  static Component fromProto(GComponent proto) => _$ComponentFromProto(proto);
  static Component fromJson(String json) =>
      _$ComponentFromProto(GComponent.fromJson(json));
}

extension GComponentProtoExtension on GComponent {
  Component toComponent() => _$ComponentFromProto(this);
}
