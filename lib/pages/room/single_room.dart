import 'package:flutter/material.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:flutter_client/widgets/livekit_widgets/controls.dart';
import 'package:flutter_client/widgets/livekit_widgets/participant.dart';

import 'dart:math' as math;

class SingleRoomPage extends StatefulWidget {
  const SingleRoomPage({Key? key}) : super(key: key);

  @override
  State<SingleRoomPage> createState() => _SingleRoomPageState();
}

class _SingleRoomPageState extends State<SingleRoomPage> {
  Room? theRoom;
  VideoTrack? track;

  List<Participant> participants = [];
  EventsListener<RoomEvent>? roomListener;

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
      theRoom?.removeListener(_onRoomDidUpdate);
      await disconnectLiveKit();
      await roomListener?.dispose();
      await theRoom?.dispose();
    }();

    super.dispose();
  }

  Future<void> connectLiveKit() async {
    var options = const ConnectOptions(
        autoSubscribe: true, protocolVersion: ProtocolVersion.v6);

    var roomOptions = const RoomOptions(
      defaultVideoPublishOptions: VideoPublishOptions(
        simulcast: true,
      ),
    );

    theRoom = await LiveKitClient.connect(
        LivekitConfig.url, variableController.accessToken ?? '',
        connectOptions: options, roomOptions: roomOptions);

    theRoom?.addListener(_onRoomDidUpdate);
    roomListener = theRoom?.createListener();

    try {
      // video will fail when running in ios simulator
      await theRoom?.localParticipant?.setCameraEnabled(true);
    } catch (e) {
      print('could not publish video: $e');
    }
    await theRoom?.localParticipant?.setMicrophoneEnabled(true);

    print('Joined room: ${theRoom?.name ?? ""}');
  }

  Future<void> disconnectLiveKit() async {
    if (theRoom != null) {
      await theRoom?.disconnect();
      theRoom = null;
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {
    List<Participant> participants = [];

    if (theRoom?.participants.isNotEmpty == true) {
      participants.addAll(theRoom!.participants.values);
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

    if (theRoom != null) {
      final localParticipant = theRoom?.localParticipant;
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
            if (theRoom?.localParticipant != null)
              SafeArea(
                top: false,
                child: ControlsWidget(theRoom!, theRoom!.localParticipant!),
              ),
          ],
        ),
      );
}
