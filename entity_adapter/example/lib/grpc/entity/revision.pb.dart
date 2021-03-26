///
//  Generated code. Do not modify.
//  source: entity/revision.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class GRevision extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GRevision', createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revisionDate', protoName: 'revisionDate')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userKey', protoName: 'userKey')
    ..hasRequiredFields = false
  ;

  GRevision._() : super();
  factory GRevision({
    $fixnum.Int64? revisionDate,
    $core.String? userKey,
  }) {
    final _result = create();
    if (revisionDate != null) {
      _result.revisionDate = revisionDate;
    }
    if (userKey != null) {
      _result.userKey = userKey;
    }
    return _result;
  }
  factory GRevision.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GRevision.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GRevision clone() => GRevision()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GRevision copyWith(void Function(GRevision) updates) => super.copyWith((message) => updates(message as GRevision)) as GRevision; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GRevision create() => GRevision._();
  GRevision createEmptyInstance() => create();
  static $pb.PbList<GRevision> createRepeated() => $pb.PbList<GRevision>();
  @$core.pragma('dart2js:noInline')
  static GRevision getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GRevision>(create);
  static GRevision? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get revisionDate => $_getI64(0);
  @$pb.TagNumber(1)
  set revisionDate($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRevisionDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRevisionDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set userKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserKey() => clearField(2);
}

