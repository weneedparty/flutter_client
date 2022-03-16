///
//  Generated code. Do not modify.
//  source: account_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = const {
  '1': 'HelloRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode('CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = const {
  '1': 'HelloReply',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode('CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = const {
  '1': 'RegisterRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode('Cg9SZWdpc3RlclJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');
@$core.Deprecated('Use registerReplyDescriptor instead')
const RegisterReply$json = const {
  '1': 'RegisterReply',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    const {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `RegisterReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerReplyDescriptor = $convert.base64Decode('Cg1SZWdpc3RlclJlcGx5EhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0EhQKBWVycm9yGAIgASgJUgVlcnJvcg==');
@$core.Deprecated('Use registerConfirmRequestDescriptor instead')
const RegisterConfirmRequest$json = const {
  '1': 'RegisterConfirmRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'random_string', '3': 2, '4': 1, '5': 9, '10': 'randomString'},
  ],
};

/// Descriptor for `RegisterConfirmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerConfirmRequestDescriptor = $convert.base64Decode('ChZSZWdpc3RlckNvbmZpcm1SZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIjCg1yYW5kb21fc3RyaW5nGAIgASgJUgxyYW5kb21TdHJpbmc=');
@$core.Deprecated('Use jWTObjectDescriptor instead')
const JWTObject$json = const {
  '1': 'JWTObject',
  '2': const [
    const {'1': 'jwt', '3': 1, '4': 1, '5': 9, '10': 'jwt'},
  ],
};

/// Descriptor for `JWTObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jWTObjectDescriptor = $convert.base64Decode('CglKV1RPYmplY3QSEAoDand0GAEgASgJUgNqd3Q=');
@$core.Deprecated('Use registerConfirmReplyDescriptor instead')
const RegisterConfirmReply$json = const {
  '1': 'RegisterConfirmReply',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.account_service.JWTObject', '10': 'result'},
    const {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `RegisterConfirmReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerConfirmReplyDescriptor = $convert.base64Decode('ChRSZWdpc3RlckNvbmZpcm1SZXBseRIyCgZyZXN1bHQYASABKAsyGi5hY2NvdW50X3NlcnZpY2UuSldUT2JqZWN0UgZyZXN1bHQSFAoFZXJyb3IYAiABKAlSBWVycm9y');
@$core.Deprecated('Use jWTIsOKRequestDescriptor instead')
const JWTIsOKRequest$json = const {
  '1': 'JWTIsOKRequest',
  '2': const [
    const {'1': 'jwt', '3': 1, '4': 1, '5': 9, '10': 'jwt'},
  ],
};

/// Descriptor for `JWTIsOKRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jWTIsOKRequestDescriptor = $convert.base64Decode('Cg5KV1RJc09LUmVxdWVzdBIQCgNqd3QYASABKAlSA2p3dA==');
@$core.Deprecated('Use jWTIsOKReplyDescriptor instead')
const JWTIsOKReply$json = const {
  '1': 'JWTIsOKReply',
  '2': const [
    const {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `JWTIsOKReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jWTIsOKReplyDescriptor = $convert.base64Decode('CgxKV1RJc09LUmVwbHkSDgoCb2sYASABKAhSAm9r');
