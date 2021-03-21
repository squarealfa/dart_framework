// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_host.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class ListsHostProtoMapper implements ProtoMapper<ListsHost, GListsHost> {
  static final ListsHostProtoMapper _singleton = ListsHostProtoMapper._();

  ListsHostProtoMapper._();
  factory ListsHostProtoMapper() => _singleton;

  @override
  ListsHost fromProto(GListsHost proto) => _$ListsHostFromProto(proto);

  @override
  GListsHost toProto(ListsHost entity) => _$ListsHostToProto(entity);

  ListsHost fromJson(String json) =>
      _$ListsHostFromProto(GListsHost.fromJson(json));
  String toJson(ListsHost entity) => _$ListsHostToProto(entity).writeToJson();
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
      .map((e) => ApplianceTypeProtoMapper().toProto(e)));

  proto.nvapplianceTypes.addAll(instance.nvapplianceTypes
          ?.map((e) => ApplianceTypeProtoMapper().toProto(e)) ??
      []);
  proto.nvapplianceTypesHasValue = instance.nvapplianceTypes != null;

  return proto;
}

ListsHost _$ListsHostFromProto(GListsHost instance) => ListsHost(
      vbools: instance.vbools.map((e) => e).toList(),
      nvbools: (instance.nvboolsHasValue
          ? (instance.nvbools.map((e) => e).toList())
          : null),
      vstrings: instance.vstrings.map((e) => e).toList(),
      nvstrings: (instance.nvstringsHasValue
          ? (instance.nvstrings.map((e) => e).toList())
          : null),
      vdurations: instance.vdurations
          .map((e) => Duration(milliseconds: e.toInt()))
          .toList(),
      nvdurations: (instance.nvdurationsHasValue
          ? (instance.nvdurations
              .map((e) => Duration(milliseconds: e.toInt()))
              .toList())
          : null),
      vdatetimes: instance.vdatetimes
          .map((e) => DateTime.fromMillisecondsSinceEpoch(e.toInt()))
          .toList(),
      nvdatetimes: (instance.nvdatetimesHasValue
          ? (instance.nvdatetimes
              .map((e) => DateTime.fromMillisecondsSinceEpoch(e.toInt()))
              .toList())
          : null),
      vdecimals: instance.vdecimals.map((e) => Decimal.parse(e)).toList(),
      nvdecimals: (instance.nvdecimalsHasValue
          ? (instance.nvdecimals.map((e) => Decimal.parse(e)).toList())
          : null),
      vints: instance.vints.map((e) => e).toList(),
      nvints: (instance.nvintsHasValue
          ? (instance.nvints.map((e) => e).toList())
          : null),
      vdoubles: instance.vdoubles.map((e) => e).toList(),
      nvdoubles: (instance.nvdoublesHasValue
          ? (instance.nvdoubles.map((e) => e).toList())
          : null),
      vapplianceTypes: instance.vapplianceTypes
          .map((e) => ApplianceTypeProtoMapper().fromProto(e))
          .toList(),
      nvapplianceTypes: (instance.nvapplianceTypesHasValue
          ? (instance.nvapplianceTypes
              .map((e) => ApplianceTypeProtoMapper().fromProto(e))
              .toList())
          : null),
    );

extension ListsHostProtoExtension on ListsHost {
  GListsHost toProto() => _$ListsHostToProto(this);
  String toJson() => _$ListsHostToProto(this).writeToJson();

  static ListsHost fromProto(GListsHost proto) => _$ListsHostFromProto(proto);
  static ListsHost fromJson(String json) =>
      _$ListsHostFromProto(GListsHost.fromJson(json));
}

extension GListsHostProtoExtension on GListsHost {
  ListsHost toListsHost() => _$ListsHostFromProto(this);
}
