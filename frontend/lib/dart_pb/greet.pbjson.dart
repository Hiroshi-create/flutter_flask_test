//
//  Generated code. Do not modify.
//  source: greet.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = {
  '1': 'HelloRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'greeting', '3': 2, '4': 1, '5': 9, '10': 'greeting'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode(
    'CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIaCghncmVldGluZxgCIAEoCVIIZ3'
    'JlZXRpbmc=');

@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = {
  '1': 'HelloReply',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode(
    'CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use delayedReplyDescriptor instead')
const DelayedReply$json = {
  '1': 'DelayedReply',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'request', '3': 2, '4': 3, '5': 11, '6': '.greet.HelloRequest', '10': 'request'},
  ],
};

/// Descriptor for `DelayedReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delayedReplyDescriptor = $convert.base64Decode(
    'CgxEZWxheWVkUmVwbHkSGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRItCgdyZXF1ZXN0GAIgAy'
    'gLMhMuZ3JlZXQuSGVsbG9SZXF1ZXN0UgdyZXF1ZXN0');

