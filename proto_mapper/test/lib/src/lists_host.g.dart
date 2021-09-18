// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_host.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class $ListsHostProtoMapper implements ProtoMapper<ListsHost, GListsHost> {
  const $ListsHostProtoMapper();

  @override
  ListsHost fromProto(GListsHost proto) => _$ListsHostFromProto(proto);

  @override
  GListsHost toProto(ListsHost entity) => _$ListsHostToProto(entity);

  ListsHost fromJson(String json) =>
      _$ListsHostFromProto(GListsHost.fromJson(json));
  String toJson(ListsHost entity) => _$ListsHostToProto(entity).writeToJson();

  String toBase64Proto(ListsHost entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  ListsHost fromBase64Proto(String base64Proto) =>
      GListsHost.fromJson(utf8.decode(base64Decode(base64Proto))).toListsHost();
}

GListsHost _$ListsHostToProto(ListsHost instance) {
  var proto = GListsHost();

  proto.vbools.addAll(instance.vbools);

  proto.nvbools.addAll(instance.nvbools ?? []);
  proto.nvboolsHasValue = instance.nvbools != null;

  proto.vstrings.addAll(instance.vstrings);

  proto.nvstrings.addAll(instance.nvstrings ?? []);
  proto.nvstringsHasValue = instance.nvstrings != null;

  proto.vdurations
      .addAll(instance.vdurations.map((e) => e.inMilliseconds.toDouble()));

  proto.nvdurations.addAll(
      instance.nvdurations?.map((e) => e.inMilliseconds.toDouble()) ?? []);
  proto.nvdurationsHasValue = instance.nvdurations != null;

  proto.vdatetimes
      .addAll(instance.vdatetimes.map((e) => Int64(e.millisecondsSinceEpoch)));

  proto.nvdatetimes.addAll(
      instance.nvdatetimes?.map((e) => Int64(e.millisecondsSinceEpoch)) ?? []);
  proto.nvdatetimesHasValue = instance.nvdatetimes != null;

  proto.vdecimals.addAll(instance.vdecimals.map((e) => e.toString()));

  proto.nvdecimals.addAll(instance.nvdecimals?.map((e) => e.toString()) ?? []);
  proto.nvdecimalsHasValue = instance.nvdecimals != null;

  proto.vints.addAll(instance.vints);

  proto.nvints.addAll(instance.nvints ?? []);
  proto.nvintsHasValue = instance.nvints != null;

  proto.vdoubles.addAll(instance.vdoubles);

  proto.nvdoubles.addAll(instance.nvdoubles ?? []);
  proto.nvdoublesHasValue = instance.nvdoubles != null;

  proto.vapplianceTypes.addAll(instance.vapplianceTypes
      .map((e) => const $ApplianceTypeProtoMapper().toProto(e)));

  proto.nvapplianceTypes.addAll(instance.nvapplianceTypes
          ?.map((e) => const $ApplianceTypeProtoMapper().toProto(e)) ??
      []);
  proto.nvapplianceTypesHasValue = instance.nvapplianceTypes != null;

  return proto;
}

ListsHost _$ListsHostFromProto(GListsHost instance) => ListsHost(
      vbools: List<bool>.unmodifiable(instance.vbools.map((e) => e)),
      nvbools: (instance.nvboolsHasValue
          ? (List<bool>.unmodifiable(instance.nvbools.map((e) => e)))
          : null),
      vstrings: List<String>.unmodifiable(instance.vstrings.map((e) => e)),
      nvstrings: (instance.nvstringsHasValue
          ? (List<String>.unmodifiable(instance.nvstrings.map((e) => e)))
          : null),
      vdurations: List<Duration>.unmodifiable(
          instance.vdurations.map((e) => Duration(milliseconds: e.toInt()))),
      nvdurations: (instance.nvdurationsHasValue
          ? (List<Duration>.unmodifiable(instance.nvdurations
              .map((e) => Duration(milliseconds: e.toInt()))))
          : null),
      vdatetimes: List<DateTime>.unmodifiable(instance.vdatetimes
          .map((e) => DateTime.fromMillisecondsSinceEpoch(e.toInt()))),
      nvdatetimes: (instance.nvdatetimesHasValue
          ? (List<DateTime>.unmodifiable(instance.nvdatetimes
              .map((e) => DateTime.fromMillisecondsSinceEpoch(e.toInt()))))
          : null),
      vdecimals: List<Decimal>.unmodifiable(
          instance.vdecimals.map((e) => Decimal.parse(e))),
      nvdecimals: (instance.nvdecimalsHasValue
          ? (List<Decimal>.unmodifiable(
              instance.nvdecimals.map((e) => Decimal.parse(e))))
          : null),
      vints: List<int>.unmodifiable(instance.vints.map((e) => e)),
      nvints: (instance.nvintsHasValue
          ? (List<int>.unmodifiable(instance.nvints.map((e) => e)))
          : null),
      vdoubles: List<double>.unmodifiable(instance.vdoubles.map((e) => e)),
      nvdoubles: (instance.nvdoublesHasValue
          ? (List<double>.unmodifiable(instance.nvdoubles.map((e) => e)))
          : null),
      vapplianceTypes: List<ApplianceType>.unmodifiable(instance.vapplianceTypes
          .map((e) => const $ApplianceTypeProtoMapper().fromProto(e))),
      nvapplianceTypes: (instance.nvapplianceTypesHasValue
          ? (List<ApplianceType>.unmodifiable(instance.nvapplianceTypes
              .map((e) => const $ApplianceTypeProtoMapper().fromProto(e))))
          : null),
    );

extension $ListsHostProtoExtension on ListsHost {
  GListsHost toProto() => _$ListsHostToProto(this);
  String toJson() => _$ListsHostToProto(this).writeToJson();

  static ListsHost fromProto(GListsHost proto) => _$ListsHostFromProto(proto);
  static ListsHost fromJson(String json) =>
      _$ListsHostFromProto(GListsHost.fromJson(json));
}

extension $GListsHostProtoExtension on GListsHost {
  ListsHost toListsHost() => _$ListsHostFromProto(this);
}
