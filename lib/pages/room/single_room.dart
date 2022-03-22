import 'package:flutter/material.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:livekit_client/livekit_client.dart' as livekit;
import 'package:flutter_client/widgets/livekit_widgets/controls.dart';
import 'package:flutter_client/widgets/livekit_widgets/participant.dart';

import 'dart:math' as math;

class SingleRoomPage extends StatefulWidget {
  const SingleRoomPage({Key? key}) : super(key: key);

  @override
  State<SingleRoomPage> createState() => _SingleRoomPageState();
}

class _SingleRoomPageState extends State<SingleRoomPage> {
  livekit.Room? theLivekitRoom;

  List<livekit.Participant> participants = [];
  livekit.EventsListener<livekit.RoomEvent>? roomListener;

  @override
  void initState() {
    super.initState();

    () async {
      await connectLiveKit();
    }();
  }

  @override
  void dispose() {
    () async {
      // always dispose listener
      theLivekitRoom?.removeListener(_onRoomDidUpdate);
      await disconnectLiveKit();
      await roomListener?.dispose();
      await theLivekitRoom?.dispose();
    }();

    super.dispose();
  }

  Future<void> connectLiveKit() async {
    var options = const livekit.ConnectOptions(
        autoSubscribe: true, protocolVersion: livekit.ProtocolVersion.v6);

    var roomOptions = const livekit.RoomOptions(
      defaultVideoPublishOptions: livekit.VideoPublishOptions(
        simulcast: true,
      ),
    );

    theLivekitRoom = await livekit.LiveKitClient.connect(
        LivekitConfig.url, variableController.accessToken ?? '',
        connectOptions: options, roomOptions: roomOptions);

    theLivekitRoom?.addListener(_onRoomDidUpdate);
    roomListener = theLivekitRoom?.createListener();

    try {
      // video will fail when running in ios simulator
      await theLivekitRoom?.localParticipant?.setCameraEnabled(true);
    } catch (e) {
      print('could not publish video: $e');
    }
    await theLivekitRoom?.localParticipant?.setMicrophoneEnabled(true);

    print('Joined room: ${theLivekitRoom?.name ?? ""}');
  }

  Future<void> disconnectLiveKit() async {
    if (theLivekitRoom != null) {
      await theLivekitRoom?.disconnect();
      theLivekitRoom = null;
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {
    List<livekit.Participant> participants = [];

    if (theLivekitRoom?.participants.isNotEmpty == true) {
      participants.addAll(theLivekitRoom!.participants.values);
      print('participants: ${participants.length}');

      // sort speakers for the grid
      participants.sort((a, b) {
        // loudest speaker first
        if (a.isSpeaking && b.isSpeaking) {
          if (a.audioLevel > b.audioLevel) {
            return -1;
          } else {
            return 1;
          }
        }

        // last spoken at
        final aSpokeAt = a.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
        final bSpokeAt = b.lastSpokeAt?.millisecondsSinceEpoch ?? 0;

        if (aSpokeAt != bSpokeAt) {
          return aSpokeAt > bSpokeAt ? -1 : 1;
        }

        // video on
        if (a.hasVideo != b.hasVideo) {
          return a.hasVideo ? -1 : 1;
        }

        // joinedAt
        return a.joinedAt.millisecondsSinceEpoch -
            b.joinedAt.millisecondsSinceEpoch;
      });
    }

    if (theLivekitRoom != null) {
      final localParticipant = theLivekitRoom?.localParticipant;
      if (localParticipant != null) {
        if (participants.length > 1) {
          participants.insert(1, localParticipant);
        } else {
          participants.add(localParticipant);
        }
      }
    }

    setState(() {
      this.participants = participants;
    });
  }

  // Future<void> addVideoTrack() async {
  //   if (theRoom == null) {
  //     return;
  //   }
  //   var localVideo = await LocalVideoTrack.createCameraTrack();
  //   await theRoom?.localParticipant?.publishVideoTrack(localVideo);
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
                child: participants.isNotEmpty
                    ? ParticipantWidget.widgetFor(participants.first)
                    : Container()),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: math.max(0, participants.length - 1),
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  width: 100,
                  height: 100,
                  child: ParticipantWidget.widgetFor(participants[index + 1]),
                ),
              ),
            ),
            if (theLivekitRoom?.localParticipant != null)
              SafeArea(
                top: false,
                child: ControlsWidget(
                    theLivekitRoom!, theLivekitRoom!.localParticipant!),
              ),
          ],
        ),
      );
}
