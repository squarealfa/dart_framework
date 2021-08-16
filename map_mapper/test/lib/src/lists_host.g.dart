// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_host.dart';

// **************************************************************************
// MapMapGenerator
// **************************************************************************

class ListsHostMapMapper extends MapMapper<ListsHost> {
  const ListsHostMapMapper();

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
          .map((e) => const ApplianceTypeMapMapper().fromMap(e))),
      nvapplianceTypes: map['nvapplianceTypes'] == null
          ? null
          : List<ApplianceType>.from(map['nvapplianceTypes']
              .map((e) => const ApplianceTypeMapMapper().fromMap(e))),
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
        .map((e) => const ApplianceTypeMapMapper().toMap(e))
        .toList();
    ;
    map['nvapplianceTypes'] = instance.nvapplianceTypes == null
        ? null
        : instance.nvapplianceTypes!
            .map((e) => const ApplianceTypeMapMapper().toMap(e))
            .toList();
    ;

    return map;
  }
}

extension ListsHostMapExtension on ListsHost {
  Map<String, dynamic> toMap([KeyHandler? keyHandler]) =>
      const ListsHostMapMapper().toMap(this, keyHandler);
  static ListsHost fromMap(Map<String, dynamic> map,
          [KeyHandler? keyHandler]) =>
      const ListsHostMapMapper().fromMap(map, keyHandler);
}

extension MapListsHostExtension on Map<String, dynamic> {
  ListsHost toListsHost([KeyHandler? keyHandler]) =>
      const ListsHostMapMapper().fromMap(this, keyHandler);
}

class $ListsHostFieldNames {
  final KeyHandler keyHandler;
  final String fieldName;
  final String prefix;

  $ListsHostFieldNames({
    KeyHandler? keyHandler,
    this.fieldName = '',
  })  : prefix = fieldName.isEmpty ? '' : fieldName + '.',
        keyHandler = keyHandler ?? KeyHandler.fromDefault();

  static const _vbools = 'vbools';
  String get vbools => prefix + _vbools;
  static const _nvbools = 'nvbools';
  String get nvbools => prefix + _nvbools;
  static const _vstrings = 'vstrings';
  String get vstrings => prefix + _vstrings;
  static const _nvstrings = 'nvstrings';
  String get nvstrings => prefix + _nvstrings;
  static const _vdurations = 'vdurations';
  String get vdurations => prefix + _vdurations;
  static const _nvdurations = 'nvdurations';
  String get nvdurations => prefix + _nvdurations;
  static const _vdatetimes = 'vdatetimes';
  String get vdatetimes => prefix + _vdatetimes;
  static const _nvdatetimes = 'nvdatetimes';
  String get nvdatetimes => prefix + _nvdatetimes;
  static const _vdecimals = 'vdecimals';
  String get vdecimals => prefix + _vdecimals;
  static const _nvdecimals = 'nvdecimals';
  String get nvdecimals => prefix + _nvdecimals;
  static const _vints = 'vints';
  String get vints => prefix + _vints;
  static const _nvints = 'nvints';
  String get nvints => prefix + _nvints;
  static const _vdoubles = 'vdoubles';
  String get vdoubles => prefix + _vdoubles;
  static const _nvdoubles = 'nvdoubles';
  String get nvdoubles => prefix + _nvdoubles;
  static const _vapplianceTypes = 'vapplianceTypes';
  String get vapplianceTypes => prefix + _vapplianceTypes;
  static const _nvapplianceTypes = 'nvapplianceTypes';
  String get nvapplianceTypes => prefix + _nvapplianceTypes;

  @override
  String toString() => fieldName;
}
