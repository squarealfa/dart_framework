///
//  Generated code. Do not modify.
//  source: empty.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GEmpty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GEmpty', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GEmpty._() : super();
  factory GEmpty() => create();
  factory GEmpty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GEmpty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GEmpty clone() => GEmpty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GEmpty copyWith(void Function(GEmpty) updates) => super.copyWith((message) => updates(message as GEmpty)) as GEmpty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GEmpty create() => GEmpty._();
  GEmpty createEmptyInstance() => create();
  static $pb.PbList<GEmpty> createRepeated() => $pb.PbList<GEmpty>();
  @$core.pragma('dart2js:noInline')
  static GEmpty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GEmpty>(create);
  static GEmpty? _defaultInstance;
}

class GListOfEmpty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListOfEmpty', createEmptyInstance: create)
    ..pc<GEmpty>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: GEmpty.create)
    ..hasRequiredFields = false
  ;

  GListOfEmpty._() : super();
  factory GListOfEmpty({
    $core.Iterable<GEmpty>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GListOfEmpty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListOfEmpty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListOfEmpty clone() => GListOfEmpty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListOfEmpty copyWith(void Function(GListOfEmpty) updates) => super.copyWith((message) => updates(message as GListOfEmpty)) as GListOfEmpty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListOfEmpty create() => GListOfEmpty._();
  GListOfEmpty createEmptyInstance() => create();
  static $pb.PbList<GListOfEmpty> createRepeated() => $pb.PbList<GListOfEmpty>();
  @$core.pragma('dart2js:noInline')
  static GListOfEmpty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListOfEmpty>(create);
  static GListOfEmpty? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GEmpty> get items => $_getList(0);
}

