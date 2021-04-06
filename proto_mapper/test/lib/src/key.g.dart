// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class KeyProtoMapper implements ProtoMapper<Key, GKey> {
  static final KeyProtoMapper _singleton = KeyProtoMapper._();

  KeyProtoMapper._();
  factory KeyProtoMapper() => _singleton;

  @override
  Key fromProto(GKey proto) => _$KeyFromProto(proto);

  @override
  GKey toProto(Key entity) => _$KeyToProto(entity);

  Key fromJson(String json) => _$KeyFromProto(GKey.fromJson(json));
  String toJson(Key entity) => _$KeyToProto(entity).writeToJson();
}

GKey _$KeyToProto(Key instance) {
  var proto = GKey();

  proto.key = instance.key;

  return proto;
}

Key _$KeyFromProto(GKey instance) => Key(
      key: instance.key,
    );

extension KeyProtoExtension on Key {
  GKey toProto() => _$KeyToProto(this);
  String toJson() => _$KeyToProto(this).writeToJson();

  static Key fromProto(GKey proto) => _$KeyFromProto(proto);
  static Key fromJson(String json) => _$KeyFromProto(GKey.fromJson(json));
}

extension GKeyProtoExtension on GKey {
  Key toKey() => _$KeyFromProto(this);
}
