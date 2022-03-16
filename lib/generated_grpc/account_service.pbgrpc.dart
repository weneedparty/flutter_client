///
//  Generated code. Do not modify.
//  source: account_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'account_service.pb.dart' as $0;
export 'account_service.pb.dart';

class AccountServiceClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/account_service.AccountService/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$userRegisterRequest =
      $grpc.ClientMethod<$0.RegisterRequest, $0.RegisterReply>(
          '/account_service.AccountService/UserRegisterRequest',
          ($0.RegisterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.RegisterReply.fromBuffer(value));
  static final _$userRegisterConfirm =
      $grpc.ClientMethod<$0.RegisterConfirmRequest, $0.RegisterConfirmReply>(
          '/account_service.AccountService/UserRegisterConfirm',
          ($0.RegisterConfirmRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RegisterConfirmReply.fromBuffer(value));
  static final _$jWTIsOK =
      $grpc.ClientMethod<$0.JWTIsOKRequest, $0.JWTIsOKReply>(
          '/account_service.AccountService/JWTIsOK',
          ($0.JWTIsOKRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.JWTIsOKReply.fromBuffer(value));

  AccountServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseFuture<$0.RegisterReply> userRegisterRequest(
      $0.RegisterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$userRegisterRequest, request, options: options);
  }

  $grpc.ResponseFuture<$0.RegisterConfirmReply> userRegisterConfirm(
      $0.RegisterConfirmRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$userRegisterConfirm, request, options: options);
  }

  $grpc.ResponseFuture<$0.JWTIsOKReply> jWTIsOK($0.JWTIsOKRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$jWTIsOK, request, options: options);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'account_service.AccountService';

  AccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.RegisterReply>(
        'UserRegisterRequest',
        userRegisterRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.RegisterReply value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RegisterConfirmRequest, $0.RegisterConfirmReply>(
            'UserRegisterConfirm',
            userRegisterConfirm_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RegisterConfirmRequest.fromBuffer(value),
            ($0.RegisterConfirmReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JWTIsOKRequest, $0.JWTIsOKReply>(
        'JWTIsOK',
        jWTIsOK_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JWTIsOKRequest.fromBuffer(value),
        ($0.JWTIsOKReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.RegisterReply> userRegisterRequest_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RegisterRequest> request) async {
    return userRegisterRequest(call, await request);
  }

  $async.Future<$0.RegisterConfirmReply> userRegisterConfirm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RegisterConfirmRequest> request) async {
    return userRegisterConfirm(call, await request);
  }

  $async.Future<$0.JWTIsOKReply> jWTIsOK_Pre(
      $grpc.ServiceCall call, $async.Future<$0.JWTIsOKRequest> request) async {
    return jWTIsOK(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello(
      $grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.RegisterReply> userRegisterRequest(
      $grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.RegisterConfirmReply> userRegisterConfirm(
      $grpc.ServiceCall call, $0.RegisterConfirmRequest request);
  $async.Future<$0.JWTIsOKReply> jWTIsOK(
      $grpc.ServiceCall call, $0.JWTIsOKRequest request);
}
