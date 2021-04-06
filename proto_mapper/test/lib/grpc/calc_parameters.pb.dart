///
//  Generated code. Do not modify.
//  source: calc_parameters.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GCalcParameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GCalcParameters', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parameter1', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parameter2', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GCalcParameters._() : super();
  factory GCalcParameters({
    $core.int? parameter1,
    $core.int? parameter2,
  }) {
    final _result = create();
    if (parameter1 != null) {
      _result.parameter1 = parameter1;
    }
    if (parameter2 != null) {
      _result.parameter2 = parameter2;
    }
    return _result;
  }
  factory GCalcParameters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GCalcParameters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GCalcParameters clone() => GCalcParameters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GCalcParameters copyWith(void Function(GCalcParameters) updates) => super.copyWith((message) => updates(message as GCalcParameters)) as GCalcParameters; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GCalcParameters create() => GCalcParameters._();
  GCalcParameters createEmptyInstance() => create();
  static $pb.PbList<GCalcParameters> createRepeated() => $pb.PbList<GCalcParameters>();
  @$core.pragma('dart2js:noInline')
  static GCalcParameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GCalcParameters>(create);
  static GCalcParameters? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get parameter1 => $_getIZ(0);
  @$pb.TagNumber(1)
  set parameter1($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasParameter1() => $_has(0);
  @$pb.TagNumber(1)
  void clearParameter1() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get parameter2 => $_getIZ(1);
  @$pb.TagNumber(2)
  set parameter2($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParameter2() => $_has(1);
  @$pb.TagNumber(2)
  void clearParameter2() => clearField(2);
}

class GListOfCalcParameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListOfCalcParameters', createEmptyInstance: create)
    ..pc<GCalcParameters>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: GCalcParameters.create)
    ..hasRequiredFields = false
  ;

  GListOfCalcParameters._() : super();
  factory GListOfCalcParameters({
    $core.Iterable<GCalcParameters>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GListOfCalcParameters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListOfCalcParameters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListOfCalcParameters clone() => GListOfCalcParameters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListOfCalcParameters copyWith(void Function(GListOfCalcParameters) updates) => super.copyWith((message) => updates(message as GListOfCalcParameters)) as GListOfCalcParameters; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListOfCalcParameters create() => GListOfCalcParameters._();
  GListOfCalcParameters createEmptyInstance() => create();
  static $pb.PbList<GListOfCalcParameters> createRepeated() => $pb.PbList<GListOfCalcParameters>();
  @$core.pragma('dart2js:noInline')
  static GListOfCalcParameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListOfCalcParameters>(create);
  static GListOfCalcParameters? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GCalcParameters> get items => $_getList(0);
}

