///
//  Generated code. Do not modify.
//  source: lists_host.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'appliance_type.pbenum.dart' as $6;

class GListsHost extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListsHost', createEmptyInstance: create)
    ..p<$core.bool>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vbools', $pb.PbFieldType.PB)
    ..p<$core.bool>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvbools', $pb.PbFieldType.PB)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvboolsHasValue', protoName: 'nvboolsHasValue')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vstrings')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvstrings')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvstringsHasValue', protoName: 'nvstringsHasValue')
    ..p<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vdurations', $pb.PbFieldType.PD)
    ..p<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdurations', $pb.PbFieldType.PD)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdurationsHasValue', protoName: 'nvdurationsHasValue')
    ..p<$fixnum.Int64>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vdatetimes', $pb.PbFieldType.P6)
    ..p<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdatetimes', $pb.PbFieldType.P6)
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdatetimesHasValue', protoName: 'nvdatetimesHasValue')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vdecimals')
    ..pPS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdecimals')
    ..aOB(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdecimalsHasValue', protoName: 'nvdecimalsHasValue')
    ..p<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vints', $pb.PbFieldType.P3)
    ..p<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvints', $pb.PbFieldType.P3)
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvintsHasValue', protoName: 'nvintsHasValue')
    ..p<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vdoubles', $pb.PbFieldType.PD)
    ..p<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdoubles', $pb.PbFieldType.PD)
    ..aOB(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvdoublesHasValue', protoName: 'nvdoublesHasValue')
    ..pc<$6.GApplianceType>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vapplianceTypes', $pb.PbFieldType.PE, protoName: 'vapplianceTypes', valueOf: $6.GApplianceType.valueOf, enumValues: $6.GApplianceType.values)
    ..pc<$6.GApplianceType>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvapplianceTypes', $pb.PbFieldType.PE, protoName: 'nvapplianceTypes', valueOf: $6.GApplianceType.valueOf, enumValues: $6.GApplianceType.values)
    ..aOB(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nvapplianceTypesHasValue', protoName: 'nvapplianceTypesHasValue')
    ..hasRequiredFields = false
  ;

  GListsHost._() : super();
  factory GListsHost({
    $core.Iterable<$core.bool>? vbools,
    $core.Iterable<$core.bool>? nvbools,
    $core.bool? nvboolsHasValue,
    $core.Iterable<$core.String>? vstrings,
    $core.Iterable<$core.String>? nvstrings,
    $core.bool? nvstringsHasValue,
    $core.Iterable<$core.double>? vdurations,
    $core.Iterable<$core.double>? nvdurations,
    $core.bool? nvdurationsHasValue,
    $core.Iterable<$fixnum.Int64>? vdatetimes,
    $core.Iterable<$fixnum.Int64>? nvdatetimes,
    $core.bool? nvdatetimesHasValue,
    $core.Iterable<$core.String>? vdecimals,
    $core.Iterable<$core.String>? nvdecimals,
    $core.bool? nvdecimalsHasValue,
    $core.Iterable<$core.int>? vints,
    $core.Iterable<$core.int>? nvints,
    $core.bool? nvintsHasValue,
    $core.Iterable<$core.double>? vdoubles,
    $core.Iterable<$core.double>? nvdoubles,
    $core.bool? nvdoublesHasValue,
    $core.Iterable<$6.GApplianceType>? vapplianceTypes,
    $core.Iterable<$6.GApplianceType>? nvapplianceTypes,
    $core.bool? nvapplianceTypesHasValue,
  }) {
    final _result = create();
    if (vbools != null) {
      _result.vbools.addAll(vbools);
    }
    if (nvbools != null) {
      _result.nvbools.addAll(nvbools);
    }
    if (nvboolsHasValue != null) {
      _result.nvboolsHasValue = nvboolsHasValue;
    }
    if (vstrings != null) {
      _result.vstrings.addAll(vstrings);
    }
    if (nvstrings != null) {
      _result.nvstrings.addAll(nvstrings);
    }
    if (nvstringsHasValue != null) {
      _result.nvstringsHasValue = nvstringsHasValue;
    }
    if (vdurations != null) {
      _result.vdurations.addAll(vdurations);
    }
    if (nvdurations != null) {
      _result.nvdurations.addAll(nvdurations);
    }
    if (nvdurationsHasValue != null) {
      _result.nvdurationsHasValue = nvdurationsHasValue;
    }
    if (vdatetimes != null) {
      _result.vdatetimes.addAll(vdatetimes);
    }
    if (nvdatetimes != null) {
      _result.nvdatetimes.addAll(nvdatetimes);
    }
    if (nvdatetimesHasValue != null) {
      _result.nvdatetimesHasValue = nvdatetimesHasValue;
    }
    if (vdecimals != null) {
      _result.vdecimals.addAll(vdecimals);
    }
    if (nvdecimals != null) {
      _result.nvdecimals.addAll(nvdecimals);
    }
    if (nvdecimalsHasValue != null) {
      _result.nvdecimalsHasValue = nvdecimalsHasValue;
    }
    if (vints != null) {
      _result.vints.addAll(vints);
    }
    if (nvints != null) {
      _result.nvints.addAll(nvints);
    }
    if (nvintsHasValue != null) {
      _result.nvintsHasValue = nvintsHasValue;
    }
    if (vdoubles != null) {
      _result.vdoubles.addAll(vdoubles);
    }
    if (nvdoubles != null) {
      _result.nvdoubles.addAll(nvdoubles);
    }
    if (nvdoublesHasValue != null) {
      _result.nvdoublesHasValue = nvdoublesHasValue;
    }
    if (vapplianceTypes != null) {
      _result.vapplianceTypes.addAll(vapplianceTypes);
    }
    if (nvapplianceTypes != null) {
      _result.nvapplianceTypes.addAll(nvapplianceTypes);
    }
    if (nvapplianceTypesHasValue != null) {
      _result.nvapplianceTypesHasValue = nvapplianceTypesHasValue;
    }
    return _result;
  }
  factory GListsHost.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListsHost.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListsHost clone() => GListsHost()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListsHost copyWith(void Function(GListsHost) updates) => super.copyWith((message) => updates(message as GListsHost)) as GListsHost; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListsHost create() => GListsHost._();
  GListsHost createEmptyInstance() => create();
  static $pb.PbList<GListsHost> createRepeated() => $pb.PbList<GListsHost>();
  @$core.pragma('dart2js:noInline')
  static GListsHost getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListsHost>(create);
  static GListsHost? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.bool> get vbools => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.bool> get nvbools => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get nvboolsHasValue => $_getBF(2);
  @$pb.TagNumber(3)
  set nvboolsHasValue($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNvboolsHasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearNvboolsHasValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get vstrings => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get nvstrings => $_getList(4);

  @$pb.TagNumber(6)
  $core.bool get nvstringsHasValue => $_getBF(5);
  @$pb.TagNumber(6)
  set nvstringsHasValue($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNvstringsHasValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearNvstringsHasValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.double> get vdurations => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.double> get nvdurations => $_getList(7);

  @$pb.TagNumber(9)
  $core.bool get nvdurationsHasValue => $_getBF(8);
  @$pb.TagNumber(9)
  set nvdurationsHasValue($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNvdurationsHasValue() => $_has(8);
  @$pb.TagNumber(9)
  void clearNvdurationsHasValue() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$fixnum.Int64> get vdatetimes => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<$fixnum.Int64> get nvdatetimes => $_getList(10);

  @$pb.TagNumber(12)
  $core.bool get nvdatetimesHasValue => $_getBF(11);
  @$pb.TagNumber(12)
  set nvdatetimesHasValue($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNvdatetimesHasValue() => $_has(11);
  @$pb.TagNumber(12)
  void clearNvdatetimesHasValue() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.String> get vdecimals => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<$core.String> get nvdecimals => $_getList(13);

  @$pb.TagNumber(15)
  $core.bool get nvdecimalsHasValue => $_getBF(14);
  @$pb.TagNumber(15)
  set nvdecimalsHasValue($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasNvdecimalsHasValue() => $_has(14);
  @$pb.TagNumber(15)
  void clearNvdecimalsHasValue() => clearField(15);

  @$pb.TagNumber(16)
  $core.List<$core.int> get vints => $_getList(15);

  @$pb.TagNumber(17)
  $core.List<$core.int> get nvints => $_getList(16);

  @$pb.TagNumber(18)
  $core.bool get nvintsHasValue => $_getBF(17);
  @$pb.TagNumber(18)
  set nvintsHasValue($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNvintsHasValue() => $_has(17);
  @$pb.TagNumber(18)
  void clearNvintsHasValue() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.double> get vdoubles => $_getList(18);

  @$pb.TagNumber(20)
  $core.List<$core.double> get nvdoubles => $_getList(19);

  @$pb.TagNumber(21)
  $core.bool get nvdoublesHasValue => $_getBF(20);
  @$pb.TagNumber(21)
  set nvdoublesHasValue($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasNvdoublesHasValue() => $_has(20);
  @$pb.TagNumber(21)
  void clearNvdoublesHasValue() => clearField(21);

  @$pb.TagNumber(22)
  $core.List<$6.GApplianceType> get vapplianceTypes => $_getList(21);

  @$pb.TagNumber(23)
  $core.List<$6.GApplianceType> get nvapplianceTypes => $_getList(22);

  @$pb.TagNumber(24)
  $core.bool get nvapplianceTypesHasValue => $_getBF(23);
  @$pb.TagNumber(24)
  set nvapplianceTypesHasValue($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasNvapplianceTypesHasValue() => $_has(23);
  @$pb.TagNumber(24)
  void clearNvapplianceTypesHasValue() => clearField(24);
}

class GListOfListsHost extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListOfListsHost', createEmptyInstance: create)
    ..pc<GListsHost>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: GListsHost.create)
    ..hasRequiredFields = false
  ;

  GListOfListsHost._() : super();
  factory GListOfListsHost({
    $core.Iterable<GListsHost>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GListOfListsHost.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListOfListsHost.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListOfListsHost clone() => GListOfListsHost()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListOfListsHost copyWith(void Function(GListOfListsHost) updates) => super.copyWith((message) => updates(message as GListOfListsHost)) as GListOfListsHost; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListOfListsHost create() => GListOfListsHost._();
  GListOfListsHost createEmptyInstance() => create();
  static $pb.PbList<GListOfListsHost> createRepeated() => $pb.PbList<GListOfListsHost>();
  @$core.pragma('dart2js:noInline')
  static GListOfListsHost getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListOfListsHost>(create);
  static GListOfListsHost? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GListsHost> get items => $_getList(0);
}

