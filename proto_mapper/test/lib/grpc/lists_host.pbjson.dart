///
//  Generated code. Do not modify.
//  source: lists_host.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gListsHostDescriptor instead')
const GListsHost$json = const {
  '1': 'GListsHost',
  '2': const [
    const {'1': 'vbools', '3': 1, '4': 3, '5': 8, '10': 'vbools'},
    const {'1': 'nvbools', '3': 2, '4': 3, '5': 8, '10': 'nvbools'},
    const {
      '1': 'nvboolsHasValue',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'nvboolsHasValue'
    },
    const {'1': 'vstrings', '3': 4, '4': 3, '5': 9, '10': 'vstrings'},
    const {'1': 'nvstrings', '3': 5, '4': 3, '5': 9, '10': 'nvstrings'},
    const {
      '1': 'nvstringsHasValue',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'nvstringsHasValue'
    },
    const {'1': 'vdurations', '3': 7, '4': 3, '5': 1, '10': 'vdurations'},
    const {'1': 'nvdurations', '3': 8, '4': 3, '5': 1, '10': 'nvdurations'},
    const {
      '1': 'nvdurationsHasValue',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'nvdurationsHasValue'
    },
    const {'1': 'vdatetimes', '3': 10, '4': 3, '5': 3, '10': 'vdatetimes'},
    const {'1': 'nvdatetimes', '3': 11, '4': 3, '5': 3, '10': 'nvdatetimes'},
    const {
      '1': 'nvdatetimesHasValue',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'nvdatetimesHasValue'
    },
    const {'1': 'vdecimals', '3': 13, '4': 3, '5': 9, '10': 'vdecimals'},
    const {'1': 'nvdecimals', '3': 14, '4': 3, '5': 9, '10': 'nvdecimals'},
    const {
      '1': 'nvdecimalsHasValue',
      '3': 15,
      '4': 1,
      '5': 8,
      '10': 'nvdecimalsHasValue'
    },
    const {'1': 'vints', '3': 16, '4': 3, '5': 5, '10': 'vints'},
    const {'1': 'nvints', '3': 17, '4': 3, '5': 5, '10': 'nvints'},
    const {
      '1': 'nvintsHasValue',
      '3': 18,
      '4': 1,
      '5': 8,
      '10': 'nvintsHasValue'
    },
    const {'1': 'vdoubles', '3': 19, '4': 3, '5': 1, '10': 'vdoubles'},
    const {'1': 'nvdoubles', '3': 20, '4': 3, '5': 1, '10': 'nvdoubles'},
    const {
      '1': 'nvdoublesHasValue',
      '3': 21,
      '4': 1,
      '5': 8,
      '10': 'nvdoublesHasValue'
    },
    const {
      '1': 'vapplianceTypes',
      '3': 22,
      '4': 3,
      '5': 14,
      '6': '.GApplianceType',
      '10': 'vapplianceTypes'
    },
    const {
      '1': 'nvapplianceTypes',
      '3': 23,
      '4': 3,
      '5': 14,
      '6': '.GApplianceType',
      '10': 'nvapplianceTypes'
    },
    const {
      '1': 'nvapplianceTypesHasValue',
      '3': 24,
      '4': 1,
      '5': 8,
      '10': 'nvapplianceTypesHasValue'
    },
  ],
};

/// Descriptor for `GListsHost`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gListsHostDescriptor = $convert.base64Decode(
    'CgpHTGlzdHNIb3N0EhYKBnZib29scxgBIAMoCFIGdmJvb2xzEhgKB252Ym9vbHMYAiADKAhSB252Ym9vbHMSKAoPbnZib29sc0hhc1ZhbHVlGAMgASgIUg9udmJvb2xzSGFzVmFsdWUSGgoIdnN0cmluZ3MYBCADKAlSCHZzdHJpbmdzEhwKCW52c3RyaW5ncxgFIAMoCVIJbnZzdHJpbmdzEiwKEW52c3RyaW5nc0hhc1ZhbHVlGAYgASgIUhFudnN0cmluZ3NIYXNWYWx1ZRIeCgp2ZHVyYXRpb25zGAcgAygBUgp2ZHVyYXRpb25zEiAKC252ZHVyYXRpb25zGAggAygBUgtudmR1cmF0aW9ucxIwChNudmR1cmF0aW9uc0hhc1ZhbHVlGAkgASgIUhNudmR1cmF0aW9uc0hhc1ZhbHVlEh4KCnZkYXRldGltZXMYCiADKANSCnZkYXRldGltZXMSIAoLbnZkYXRldGltZXMYCyADKANSC252ZGF0ZXRpbWVzEjAKE252ZGF0ZXRpbWVzSGFzVmFsdWUYDCABKAhSE252ZGF0ZXRpbWVzSGFzVmFsdWUSHAoJdmRlY2ltYWxzGA0gAygJUgl2ZGVjaW1hbHMSHgoKbnZkZWNpbWFscxgOIAMoCVIKbnZkZWNpbWFscxIuChJudmRlY2ltYWxzSGFzVmFsdWUYDyABKAhSEm52ZGVjaW1hbHNIYXNWYWx1ZRIUCgV2aW50cxgQIAMoBVIFdmludHMSFgoGbnZpbnRzGBEgAygFUgZudmludHMSJgoObnZpbnRzSGFzVmFsdWUYEiABKAhSDm52aW50c0hhc1ZhbHVlEhoKCHZkb3VibGVzGBMgAygBUgh2ZG91YmxlcxIcCgludmRvdWJsZXMYFCADKAFSCW52ZG91YmxlcxIsChFudmRvdWJsZXNIYXNWYWx1ZRgVIAEoCFIRbnZkb3VibGVzSGFzVmFsdWUSOQoPdmFwcGxpYW5jZVR5cGVzGBYgAygOMg8uR0FwcGxpYW5jZVR5cGVSD3ZhcHBsaWFuY2VUeXBlcxI7ChBudmFwcGxpYW5jZVR5cGVzGBcgAygOMg8uR0FwcGxpYW5jZVR5cGVSEG52YXBwbGlhbmNlVHlwZXMSOgoYbnZhcHBsaWFuY2VUeXBlc0hhc1ZhbHVlGBggASgIUhhudmFwcGxpYW5jZVR5cGVzSGFzVmFsdWU=');
