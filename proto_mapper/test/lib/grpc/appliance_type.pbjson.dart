///
//  Generated code. Do not modify.
//  source: appliance_type.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gApplianceTypeDescriptor instead')
const GApplianceType$json = const {
  '1': 'GApplianceType',
  '2': const [
    const {'1': 'Heat', '2': 0},
    const {'1': 'Cold', '2': 1},
    const {'1': 'Cutlery', '2': 2},
  ],
};

/// Descriptor for `GApplianceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gApplianceTypeDescriptor = $convert.base64Decode(
    'Cg5HQXBwbGlhbmNlVHlwZRIICgRIZWF0EAASCAoEQ29sZBABEgsKB0N1dGxlcnkQAg==');
@$core.Deprecated('Use nullableGApplianceTypeDescriptor instead')
const NullableGApplianceType$json = const {
  '1': 'NullableGApplianceType',
  '2': const [
    const {'1': 'hasValue', '3': 1, '4': 1, '5': 8, '10': 'hasValue'},
    const {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.GApplianceType',
      '10': 'value'
    },
  ],
};

/// Descriptor for `NullableGApplianceType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nullableGApplianceTypeDescriptor =
    $convert.base64Decode(
        'ChZOdWxsYWJsZUdBcHBsaWFuY2VUeXBlEhoKCGhhc1ZhbHVlGAEgASgIUghoYXNWYWx1ZRIlCgV2YWx1ZRgCIAEoDjIPLkdBcHBsaWFuY2VUeXBlUgV2YWx1ZQ==');
