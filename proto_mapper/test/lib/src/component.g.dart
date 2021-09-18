// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class $ComponentProtoMapper implements ProtoMapper<Component, GComponent> {
  const $ComponentProtoMapper();

  @override
  Component fromProto(GComponent proto) => _$ComponentFromProto(proto);

  @override
  GComponent toProto(Component entity) => _$ComponentToProto(entity);

  Component fromJson(String json) =>
      _$ComponentFromProto(GComponent.fromJson(json));
  String toJson(Component entity) => _$ComponentToProto(entity).writeToJson();

  String toBase64Proto(Component entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  Component fromBase64Proto(String base64Proto) =>
      GComponent.fromJson(utf8.decode(base64Decode(base64Proto))).toComponent();
}

GComponent _$ComponentToProto(Component instance) {
  var proto = GComponent();

  proto.description = instance.description;

  return proto;
}

Component _$ComponentFromProto(GComponent instance) => Component(
      description: instance.description,
    );

extension $ComponentProtoExtension on Component {
  GComponent toProto() => _$ComponentToProto(this);
  String toJson() => _$ComponentToProto(this).writeToJson();

  static Component fromProto(GComponent proto) => _$ComponentFromProto(proto);
  static Component fromJson(String json) =>
      _$ComponentFromProto(GComponent.fromJson(json));
}

extension $GComponentProtoExtension on GComponent {
  Component toComponent() => _$ComponentFromProto(this);
}
