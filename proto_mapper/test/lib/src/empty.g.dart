// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class EmptyProtoMapper implements ProtoMapper<Empty, GEmpty> {
  const EmptyProtoMapper();

  @override
  Empty fromProto(GEmpty proto) => _$EmptyFromProto(proto);

  @override
  GEmpty toProto(Empty entity) => _$EmptyToProto(entity);

  Empty fromJson(String json) => _$EmptyFromProto(GEmpty.fromJson(json));
  String toJson(Empty entity) => _$EmptyToProto(entity).writeToJson();

  String toBase64Proto(Empty entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  Empty fromBase64Proto(String base64Proto) =>
      GEmpty.fromJson(utf8.decode(base64Decode(base64Proto))).toEmpty();
}

GEmpty _$EmptyToProto(Empty instance) {
  var proto = GEmpty();

  return proto;
}

Empty _$EmptyFromProto(GEmpty instance) => Empty();

extension EmptyProtoExtension on Empty {
  GEmpty toProto() => _$EmptyToProto(this);
  String toJson() => _$EmptyToProto(this).writeToJson();

  static Empty fromProto(GEmpty proto) => _$EmptyFromProto(proto);
  static Empty fromJson(String json) => _$EmptyFromProto(GEmpty.fromJson(json));
}

extension GEmptyProtoExtension on GEmpty {
  Empty toEmpty() => _$EmptyFromProto(this);
}
