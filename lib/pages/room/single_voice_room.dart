import 'package:flutter_client/models/room.dart';
import 'package:flutter_client/models/user.dart';
import 'package:flutter_client/pages/room/widgets/my_room_profile.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/utils/data.dart';
import 'package:flutter_client/utils/style.dart';
import 'package:flutter_client/utils/utils.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter_client/widgets/round_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:livekit_client/livekit_client.dart' as livekit;

Map<String, String> identityPictureMap = {};
String getARandomCatPicturePath(String identity) {
  if (identity.isEmpty) {
    return "";
  }

  if (identityPictureMap.containsKey(identity)) {
    return identityPictureMap[identity]!;
  } else {
    String path = 'assets/images/cat${getARandomNumber(1, 9)}.jpg';
    identityPictureMap[identity] = path;
    return path;
  }
}

class SingleVoiceRoom extends StatefulWidget {
  const SingleVoiceRoom({Key? key}) : super(key: key);

  @override
  State<SingleVoiceRoom> createState() => _SingleVoiceRoomState();
}

class _SingleVoiceRoomState extends State<SingleVoiceRoom> {
  User? myProfile;
  Room? room;

  livekit.Room? theLivekitRoom;

  List<livekit.Participant> participants = [];
  livekit.EventsListener<livekit.RoomEvent>? roomListener;

  @override
  void initState() {
    super.initState();

    () async {
      myProfile = User.fromJson({
        'name': variableController.userEmail,
        'username': variableController.userEmail,
        'profileImage': 'assets/images/cat2.jpg',
        'followers': '1k',
        'following': '1',
        'lastAccessTime': '0m',
        'isNewUser': false,
      });
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
      defaultAudioCaptureOptions: livekit.AudioCaptureOptions(
        echoCancellation: true,
        noiseSuppression: true,
      ),
    );

    theLivekitRoom = await livekit.LiveKitClient.connect(
        LivekitConfig.url, variableController.accessToken ?? '',
        connectOptions: options, roomOptions: roomOptions);

    theLivekitRoom?.addListener(_onRoomDidUpdate);
    roomListener = theLivekitRoom?.createListener();

    // try {
    //   // video will fail when running in ios simulator
    //   await theLivekitRoom?.localParticipant?.setCameraEnabled(true);
    // } catch (e) {
    //   print('could not publish video: $e');
    // }

    // await theLivekitRoom?.localParticipant?.setMicrophoneEnabled(true);

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
    if (theLivekitRoom == null) return;

    // update participants
    List<livekit.Participant> tempParticipants = [];

    if (theLivekitRoom?.participants.isNotEmpty == true) {
      tempParticipants.addAll(theLivekitRoom!.participants.values);
      print('participants: ${tempParticipants.length}');

      // sort speakers for the grid
      tempParticipants.sort((a, b) {
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
      final tempLocalParticipant = theLivekitRoom?.localParticipant;
      if (tempLocalParticipant != null) {
        if (tempParticipants.length > 1) {
          tempParticipants.insert(1, tempLocalParticipant);
        } else {
          tempParticipants.add(tempLocalParticipant);
        }
      }
    }

    // update room
    Room? tempRoom = Room.fromJson({
      'title': theLivekitRoom?.name ?? '',
      "users": participants
          .map((participant) => User.fromJson({
                'username': participant.identity,
                'name': participant.identity
                    .substring(0, [8, participant.identity.length].reduce(min)),
                'profileImage': getARandomCatPicturePath(participant.identity),
                'microphoneOn': participant.isMicrophoneEnabled(),
                'isSpeaking': participant.isSpeaking,
              }))
          .toList(),
      'speakerCount': participants.length,
    });

    setState(() {
      participants = tempParticipants;
      room = tempRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 141, 171, 207),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {},
                  ),
                  const Text(
                    'All rooms',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                //head picture
                // grpcController.getCurrentUserUUIDlist();
              },
              child: RoundImage(
                path: getARandomCatPicturePath(myProfile?.username ?? ""),
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: room == null
          ? const Center(child: Text('loading...'))
          : Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        bottom: 80,
                        top: 20,
                      ),
                      child: Column(
                        children: [
                          buildTitle(room?.title ?? ""),
                          const SizedBox(
                            height: 30,
                          ),
                          buildSpeakers(
                              room?.users.sublist(0, room?.speakerCount ?? 0) ??
                                  []),
                          // buildOthers(room.users.sublist(room.speakerCount)),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: buildBottom(context),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }

  Widget buildSpeakers(List<User> users) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      itemCount: users.length,
      itemBuilder: (gc, index) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            if (users[index].username == (myProfile?.username ?? "")) {
              var localParticipant = theLivekitRoom?.localParticipant;
              if (localParticipant != null) {
                if (localParticipant.isMuted) {
                  await theLivekitRoom?.localParticipant
                      ?.setMicrophoneEnabled(true);
                } else {
                  await theLivekitRoom?.localParticipant
                      ?.setMicrophoneEnabled(false);
                }
              }
            }
          },
          child: MyRoomProfile(
            user: users[index],
            isModerator: false,
            isMute: !users[index].microphoneOn,
            isSpeaking: users[index].isSpeaking,
            size: 80,
          ),
        );
      },
    );
  }

  Widget buildBottom(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          RoundButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Style.LightGrey,
            child: const Text(
              '✌️ Leave quietly',
              style: TextStyle(
                color: Style.AccentRed,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          RoundButton(
            onPressed: () async {},
            color: Style.LightGrey,
            isCircle: true,
            child: const Icon(
              Icons.add,
              size: 15,
              color: Colors.black,
            ),
          ),
          RoundButton(
            onPressed: () async {},
            color: Style.LightGrey,
            isCircle: true,
            child: const Icon(
              Icons.thumb_up,
              size: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
