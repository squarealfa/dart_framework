// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_host.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class ListsHostMapMapper extends MapMapper<ListsHost> {
  static final ListsHostMapMapper _singleton = ListsHostMapMapper._();

  ListsHostMapMapper._();
  factory ListsHostMapMapper() => _singleton;

  @override
  ListsHost fromMap(
    Map<String, dynamic> map, [
    KeyHandler? keyHandler,
  ]) {
    return ListsHost(
      vbools: List<bool>.from(map['vbools']),
      nvbools: map['nvbools'] == null ? null : List<bool>.from(map['nvbools']),
      vstrings: List<String>.from(map['vstrings']),
      nvstrings:
          map['nvstrings'] == null ? null : List<String>.from(map['nvstrings']),
      vdurations: List<Duration>.from(map['vdurations']),
      nvdurations: map['nvdurations'] == null
          ? null
          : List<Duration>.from(map['nvdurations']),
      vdatetimes: List<DateTime>.from(map['vdatetimes']),
      nvdatetimes: map['nvdatetimes'] == null
          ? null
          : List<DateTime>.from(map['nvdatetimes']),
      vdecimals: List<Decimal>.from(map['vdecimals']),
      nvdecimals: map['nvdecimals'] == null
          ? null
          : List<Decimal>.from(map['nvdecimals']),
      vints: List<int>.from(map['vints']),
      nvints: map['nvints'] == null ? null : List<int>.from(map['nvints']),
      vdoubles: List<double>.from(map['vdoubles']),
      nvdoubles:
          map['nvdoubles'] == null ? null : List<double>.from(map['nvdoubles']),
      vapplianceTypes: List<ApplianceType>.from(map['vapplianceTypes']
          .map((e) => ApplianceTypeMapMapper().fromMap(e))),
      nvapplianceTypes: map['nvapplianceTypes'] == null
          ? null
          : List<ApplianceType>.from(map['nvapplianceTypes']
              .map((e) => ApplianceTypeMapMapper().fromMap(e))),
    );
  }

  @override
  Map<String, dynamic> toMap(
    ListsHost instance, [
    KeyHandler? keyHandler,
  ]) {
    final map = <String, dynamic>{};

    map['vbools'] = instance.vbools;
    ;
    map['nvbools'] = instance.nvbools;
    ;
    map['vstrings'] = instance.vstrings;
    ;
    map['nvstrings'] = instance.nvstrings;
    ;
    map['vdurations'] = instance.vdurations;
    ;
    map['nvdurations'] = instance.nvdurations;
    ;
    map['vdatetimes'] = instance.vdatetimes;
    ;
    map['nvdatetimes'] = instance.nvdatetimes;
    ;
    map['vdecimals'] = instance.vdecimals;
    ;
    map['nvdecimals'] = instance.nvdecimals;
    ;
    map['vints'] = instance.vints;
    ;
    map['nvints'] = instance.nvints;
    ;
    map['vdoubles'] = instance.vdoubles;
    ;
    map['nvdoubles'] = instance.nvdoubles;
    ;
    map['vapplianceTypes'] = instance.vapplianceTypes
        .map((e) => ApplianceTypeMapMapper().toMap(e))
        .toList();
    ;
    map['nvapplianceTypes'] = instance.nvapplianceTypes == null
        ? null
        : instance.nvapplianceTypes!
            .map((e) => ApplianceTypeMapMapper().toMap(e))
            .toList();
    ;

    return map;
  }
}

extension ListsHostMapExtension on ListsHost {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      ListsHostMapMapper().toMap(this, keyHandler);
  static ListsHost fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      ListsHostMapMapper().fromMap(map, keyHandler);
}

extension MapListsHostExtension on Map<String, dynamic> {
  ListsHost toListsHost([KeyHandler? keyHandler]) =>
      ListsHostMapMapper().fromMap(this, keyHandler);
}
