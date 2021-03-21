///
//  Generated code. Do not modify.
//  source: appliance_type.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'appliance_type.pbenum.dart';

export 'appliance_type.pbenum.dart';

class NullableGApplianceType extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NullableGApplianceType',
      createEmptyInstance: create)
    ..aOB(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hasValue',
        protoName: 'hasValue')
    ..e<GApplianceType>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'value',
        $pb.PbFieldType.OE,
        defaultOrMaker: GApplianceType.Heat,
        valueOf: GApplianceType.valueOf,
        enumValues: GApplianceType.values)
    ..hasRequiredFields = false;

  NullableGApplianceType._() : super();
  factory NullableGApplianceType({
    $core.bool? hasValue,
    GApplianceType? value_2,
  }) {
    final _result = create();
    if (hasValue != null) {
      _result.hasValue = hasValue;
    }
    if (value_2 != null) {
      _result.value_2 = value_2;
    }
    return _result;
  }
  factory NullableGApplianceType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NullableGApplianceType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NullableGApplianceType clone() =>
      NullableGApplianceType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NullableGApplianceType copyWith(
          void Function(NullableGApplianceType) updates) =>
      super.copyWith((message) => updates(message as NullableGApplianceType))
          as NullableGApplianceType; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NullableGApplianceType create() => NullableGApplianceType._();
  NullableGApplianceType createEmptyInstance() => create();
  static $pb.PbList<NullableGApplianceType> createRepeated() =>
      $pb.PbList<NullableGApplianceType>();
  @$core.pragma('dart2js:noInline')
  static NullableGApplianceType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NullableGApplianceType>(create);
  static NullableGApplianceType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasValue => $_getBF(0);
  @$pb.TagNumber(1)
  set hasValue($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasValue() => clearField(1);

  @$pb.TagNumber(2)
  GApplianceType get value_2 => $_getN(1);
  @$pb.TagNumber(2)
  set value_2(GApplianceType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue_2() => clearField(2);
}
