///
//  Generated code. Do not modify.
//  source: calc_result.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GCalcResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GCalcResult', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GCalcResult._() : super();
  factory GCalcResult({
    $core.int? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory GCalcResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GCalcResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GCalcResult clone() => GCalcResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GCalcResult copyWith(void Function(GCalcResult) updates) => super.copyWith((message) => updates(message as GCalcResult)) as GCalcResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GCalcResult create() => GCalcResult._();
  GCalcResult createEmptyInstance() => create();
  static $pb.PbList<GCalcResult> createRepeated() => $pb.PbList<GCalcResult>();
  @$core.pragma('dart2js:noInline')
  static GCalcResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GCalcResult>(create);
  static GCalcResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get result => $_getIZ(0);
  @$pb.TagNumber(1)
  set result($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

class GListOfCalcResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListOfCalcResult', createEmptyInstance: create)
    ..pc<GCalcResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: GCalcResult.create)
    ..hasRequiredFields = false
  ;

  GListOfCalcResult._() : super();
  factory GListOfCalcResult({
    $core.Iterable<GCalcResult>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GListOfCalcResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListOfCalcResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListOfCalcResult clone() => GListOfCalcResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListOfCalcResult copyWith(void Function(GListOfCalcResult) updates) => super.copyWith((message) => updates(message as GListOfCalcResult)) as GListOfCalcResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListOfCalcResult create() => GListOfCalcResult._();
  GListOfCalcResult createEmptyInstance() => create();
  static $pb.PbList<GListOfCalcResult> createRepeated() => $pb.PbList<GListOfCalcResult>();
  @$core.pragma('dart2js:noInline')
  static GListOfCalcResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListOfCalcResult>(create);
  static GListOfCalcResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GCalcResult> get items => $_getList(0);
}

