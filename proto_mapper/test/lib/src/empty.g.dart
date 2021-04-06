// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class EmptyProtoMapper implements ProtoMapper<Empty, GEmpty> {
  static final EmptyProtoMapper _singleton = EmptyProtoMapper._();

  EmptyProtoMapper._();
  factory EmptyProtoMapper() => _singleton;

  @override
  Empty fromProto(GEmpty proto) => _$EmptyFromProto(proto);

  @override
  GEmpty toProto(Empty entity) => _$EmptyToProto(entity);

  Empty fromJson(String json) => _$EmptyFromProto(GEmpty.fromJson(json));
  String toJson(Empty entity) => _$EmptyToProto(entity).writeToJson();
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
