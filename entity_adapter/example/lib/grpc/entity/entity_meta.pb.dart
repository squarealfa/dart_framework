///
//  Generated code. Do not modify.
//  source: entity/entity_meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'entity_share.pb.dart' as $0;
import 'revision.pb.dart' as $1;

class GEntityMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GEntityMeta', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tenantKey', protoName: 'tenantKey')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ownerKeys', protoName: 'ownerKeys')
    ..pc<$0.GEntityShare>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shares', $pb.PbFieldType.PM, subBuilder: $0.GEntityShare.create)
    ..pc<$1.GRevision>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revisions', $pb.PbFieldType.PM, subBuilder: $1.GRevision.create)
    ..hasRequiredFields = false
  ;

  GEntityMeta._() : super();
  factory GEntityMeta({
    $core.String? tenantKey,
    $core.Iterable<$core.String>? ownerKeys,
    $core.Iterable<$0.GEntityShare>? shares,
    $core.Iterable<$1.GRevision>? revisions,
  }) {
    final _result = create();
    if (tenantKey != null) {
      _result.tenantKey = tenantKey;
    }
    if (ownerKeys != null) {
      _result.ownerKeys.addAll(ownerKeys);
    }
    if (shares != null) {
      _result.shares.addAll(shares);
    }
    if (revisions != null) {
      _result.revisions.addAll(revisions);
    }
    return _result;
  }
  factory GEntityMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GEntityMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GEntityMeta clone() => GEntityMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GEntityMeta copyWith(void Function(GEntityMeta) updates) => super.copyWith((message) => updates(message as GEntityMeta)) as GEntityMeta; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GEntityMeta create() => GEntityMeta._();
  GEntityMeta createEmptyInstance() => create();
  static $pb.PbList<GEntityMeta> createRepeated() => $pb.PbList<GEntityMeta>();
  @$core.pragma('dart2js:noInline')
  static GEntityMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GEntityMeta>(create);
  static GEntityMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tenantKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set tenantKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTenantKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearTenantKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get ownerKeys => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$0.GEntityShare> get shares => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$1.GRevision> get revisions => $_getList(3);
}

