///
//  Generated code. Do not modify.
//  source: asset.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use gAssetDescriptor instead')
const GAsset$json = const {
  '1': 'GAsset',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `GAsset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gAssetDescriptor = $convert.base64Decode('CgZHQXNzZXQSIAoLZGVzY3JpcHRpb24YASABKAlSC2Rlc2NyaXB0aW9uEhQKBXZhbHVlGAIgASgJUgV2YWx1ZQ==');
@$core.Deprecated('Use gListOfAssetDescriptor instead')
const GListOfAsset$json = const {
  '1': 'GListOfAsset',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.GAsset', '10': 'items'},
  ],
};

/// Descriptor for `GListOfAsset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gListOfAssetDescriptor = $convert.base64Decode('CgxHTGlzdE9mQXNzZXQSHQoFaXRlbXMYASADKAsyBy5HQXNzZXRSBWl0ZW1z');
