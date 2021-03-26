///
//  Generated code. Do not modify.
//  source: entity/entity_share.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GEntityShare extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GEntityShare', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userKey', protoName: 'userKey')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actions')
    ..hasRequiredFields = false
  ;

  GEntityShare._() : super();
  factory GEntityShare({
    $core.String? userKey,
    $core.Iterable<$core.String>? actions,
  }) {
    final _result = create();
    if (userKey != null) {
      _result.userKey = userKey;
    }
    if (actions != null) {
      _result.actions.addAll(actions);
    }
    return _result;
  }
  factory GEntityShare.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GEntityShare.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GEntityShare clone() => GEntityShare()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GEntityShare copyWith(void Function(GEntityShare) updates) => super.copyWith((message) => updates(message as GEntityShare)) as GEntityShare; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GEntityShare create() => GEntityShare._();
  GEntityShare createEmptyInstance() => create();
  static $pb.PbList<GEntityShare> createRepeated() => $pb.PbList<GEntityShare>();
  @$core.pragma('dart2js:noInline')
  static GEntityShare getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GEntityShare>(create);
  static GEntityShare? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set userKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get actions => $_getList(1);
}

