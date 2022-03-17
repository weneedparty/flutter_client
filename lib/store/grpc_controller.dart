import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_client/generated_grpc/account_service.pbgrpc.dart'
    as account_service;
import 'package:flutter_client/generated_grpc/helloworld.pbgrpc.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/utils.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';

class GrpcControllr extends GetxController {
  ClientChannel sendingChannel = ClientChannel(
    GrpcConfig.hostIPAddress,
    port: GrpcConfig.helloworldPortNumber,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  ClientChannel receivingChannel = ClientChannel(
    GrpcConfig.hostIPAddress,
    port: GrpcConfig.helloworldPortNumber,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  void recreateSendingChannel() {
    sendingChannel = ClientChannel(
      GrpcConfig.hostIPAddress,
      port: GrpcConfig.helloworldPortNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  void recreateReceivingChannel() {
    receivingChannel = ClientChannel(
      GrpcConfig.hostIPAddress,
      port: GrpcConfig.helloworldPortNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  ClientChannel getATempraryChannel() {
    return ClientChannel(
      GrpcConfig.hostIPAddress,
      port: GrpcConfig.helloworldPortNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  Future<void> test() async {
    final stub = GreeterClient(sendingChannel);
    final response = await stub.sayHello(HelloRequest()..name = 'you');
    print('Greeter client received: ${response.message}');
    await sendingChannel.shutdown();
  }

  Stream<VoiceRequest> getNewVoiceStreamForUpload(Stream stream) async* {
    await for (final value in stream) {
      VoiceRequest voiceRequest = VoiceRequest()..voice = value.cast<int>();
      voiceRequest.uuid = variableController.ourUUID;
      voiceRequest.timestamp = getCurrentTimeInMilliseconds();
      // print(voiceRequest.timestamp);
      yield voiceRequest;
    }
  }

  Future<void> sendVoiceDataOut(Stream? stream) async {
    if (stream == null) {
      return;
    }

    Stream<VoiceRequest> newStream = getNewVoiceStreamForUpload(stream);

    final stub = GreeterClient(sendingChannel);
    final response = await stub.sendVoice(newStream);
    // print('Greeter client received: ${response}');
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // exit app
  }

  Future<void> getVoiceDataFromService() async {
    final stub = GreeterClient(receivingChannel);

    // await microphoneAndSpeakerController.player.start();

    final response = stub.getVoice(Empty());
    response.listen((VoiceReply voiceResponse) {
      () async {
        // print(voiceResponse);
        microphoneAndSpeakerController.player
            .writeChunk(Uint8List.fromList(voiceResponse.voice));
      }();
      // print('Greeter client received: ${voiceResponse.voice}');
    });

    microphoneAndSpeakerController.isReceiving.trigger(true);
  }

  Future<void> shutdownSendingChannel() async {
    await sendingChannel.shutdown();
    recreateSendingChannel();
    microphoneAndSpeakerController.isRecording.trigger(false);
  }

  Future<void> shutdownReceivingChannel() async {
    await receivingChannel.shutdown();
    recreateReceivingChannel();
    microphoneAndSpeakerController.isReceiving.trigger(false);
  }

  Future<List<String>> getCurrentUserUUIDlist() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub.getCurrentUsersUUID(Empty());
    print('Greeter client received: ${response.uuid}');
    await temporaryChannel.shutdown();
    return response.uuid;
  }

  Future<void> startSpeaking() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub.startSpeaking(
        StartSpeakingRequest()..uuid = variableController.ourUUID);
    await temporaryChannel.shutdown();
  }

  Future<void> stopSpeaking() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub
        .stopSpeaking(StopSpeakingRequest()..uuid = variableController.ourUUID);
    await temporaryChannel.shutdown();
  }
}

class JWTGrpcControllr extends GetxController {
  ClientChannel channel = ClientChannel(
    GrpcConfig.hostIPAddress,
    port: GrpcConfig.accountservicePortNumber,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  CallOptions getJWTCallOptionsForGRPC() {
    return CallOptions(
      metadata: <String, String>{
        'jwt': "a fake jwt",
      },
    );
  }

  void recreateChannel() {
    channel = ClientChannel(
      GrpcConfig.hostIPAddress,
      port: GrpcConfig.accountservicePortNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  Future<void> test() async {
    recreateChannel();

    try {
      final stub = account_service.AccountServiceClient(channel);
      final response = await stub.sayHello(
        account_service.HelloRequest()..name = 'you',
      );
      // options: getJWTCallOptionsForGRPC());
      print('Greeter client received: ${response.message}');
      await channel.shutdown();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> preRegister({required String email}) async {
    recreateChannel();

    try {
      final stub = account_service.AccountServiceClient(channel);
      final response = await stub.userRegisterRequest(
          account_service.RegisterRequest()..email = email);

      String error = response.error;
      if (error.length != 0) {
        print('pre_register failed: $error');
        return false;
      }

      await channel.shutdown();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> registerConfirm(
      {required String email, required String code}) async {
    recreateChannel();

    try {
      final stub = account_service.AccountServiceClient(channel);

      final response = await stub.userRegisterConfirm(
        account_service.RegisterConfirmRequest()
          ..email = email
          ..randomString = code,
      );

      String error = response.error;
      if (error.length != 0) {
        print('register_confirm failed: $error');
        return null;
      }

      await channel.shutdown();

      return response.result.jwt;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> authJwt({required String jwt}) async {
    recreateChannel();

    try {
      final stub = account_service.AccountServiceClient(channel);

      final response =
          await stub.jWTIsOK(account_service.JWTIsOKRequest()..jwt = jwt);

      bool ok = response.ok;
      if (ok == false) {
        print('jwt is not ok');
        return null;
      }

      await channel.shutdown();

      return response.email;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
