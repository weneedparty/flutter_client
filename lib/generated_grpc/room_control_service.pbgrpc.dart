///
//  Generated code. Do not modify.
//  source: room_control_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'room_control_service.pb.dart' as $0;
export 'room_control_service.pb.dart';

class RoomControlServiceClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/room_control_service.RoomControlService/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$createRoom =
      $grpc.ClientMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
          '/room_control_service.RoomControlService/CreateRoom',
          ($0.CreateRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateRoomResponse.fromBuffer(value));
  static final _$allowJoin =
      $grpc.ClientMethod<$0.AllowJoinRequest, $0.AllowJoinResponse>(
          '/room_control_service.RoomControlService/AllowJoin',
          ($0.AllowJoinRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AllowJoinResponse.fromBuffer(value));
  static final _$listRooms =
      $grpc.ClientMethod<$0.ListRoomsRequest, $0.ListRoomsResponse>(
          '/room_control_service.RoomControlService/ListRooms',
          ($0.ListRoomsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListRoomsResponse.fromBuffer(value));
  static final _$deleteRoom =
      $grpc.ClientMethod<$0.DeleteRoomRequest, $0.DeleteRoomResponse>(
          '/room_control_service.RoomControlService/DeleteRoom',
          ($0.DeleteRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteRoomResponse.fromBuffer(value));

  RoomControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateRoomResponse> createRoom(
      $0.CreateRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRoom, request, options: options);
  }

  $grpc.ResponseFuture<$0.AllowJoinResponse> allowJoin(
      $0.AllowJoinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$allowJoin, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListRoomsResponse> listRooms(
      $0.ListRoomsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRooms, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteRoomResponse> deleteRoom(
      $0.DeleteRoomRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRoom, request, options: options);
  }
}

abstract class RoomControlServiceBase extends $grpc.Service {
  $core.String get $name => 'room_control_service.RoomControlService';

  RoomControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
        'CreateRoom',
        createRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRoomRequest.fromBuffer(value),
        ($0.CreateRoomResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AllowJoinRequest, $0.AllowJoinResponse>(
        'AllowJoin',
        allowJoin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AllowJoinRequest.fromBuffer(value),
        ($0.AllowJoinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRoomsRequest, $0.ListRoomsResponse>(
        'ListRooms',
        listRooms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListRoomsRequest.fromBuffer(value),
        ($0.ListRoomsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRoomRequest, $0.DeleteRoomResponse>(
        'DeleteRoom',
        deleteRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteRoomRequest.fromBuffer(value),
        ($0.DeleteRoomResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.CreateRoomResponse> createRoom_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateRoomRequest> request) async {
    return createRoom(call, await request);
  }

  $async.Future<$0.AllowJoinResponse> allowJoin_Pre($grpc.ServiceCall call,
      $async.Future<$0.AllowJoinRequest> request) async {
    return allowJoin(call, await request);
  }

  $async.Future<$0.ListRoomsResponse> listRooms_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListRoomsRequest> request) async {
    return listRooms(call, await request);
  }

  $async.Future<$0.DeleteRoomResponse> deleteRoom_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeleteRoomRequest> request) async {
    return deleteRoom(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello(
      $grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.CreateRoomResponse> createRoom(
      $grpc.ServiceCall call, $0.CreateRoomRequest request);
  $async.Future<$0.AllowJoinResponse> allowJoin(
      $grpc.ServiceCall call, $0.AllowJoinRequest request);
  $async.Future<$0.ListRoomsResponse> listRooms(
      $grpc.ServiceCall call, $0.ListRoomsRequest request);
  $async.Future<$0.DeleteRoomResponse> deleteRoom(
      $grpc.ServiceCall call, $0.DeleteRoomRequest request);
}
