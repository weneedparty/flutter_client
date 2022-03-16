import 'package:flutter_client/models/room.dart';
import 'package:flutter_client/models/user.dart';
import 'package:flutter_client/pages/room/widgets/my_room_profile.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/util/data.dart';
import 'package:flutter_client/util/style.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter_client/widgets/round_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomPage extends StatelessWidget {
  final Room room;

  const RoomPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            const Text(
              'All rooms',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                //head picture
                grpcController.getCurrentUserUUIDlist();
              },
              child: RoundImage(
                path: myProfile.profileImage,
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: Container(
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
              onNotification: (OverscrollIndicatorNotification overscroll) {
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
                    buildTitle(room.title),
                    const SizedBox(
                      height: 30,
                    ),
                    buildSpeakers(room.users.sublist(0, room.speakerCount)),
                    // buildOthers(room.users.sublist(room.speakerCount)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Ripples(
                                color: Colors.blueAccent,
                                waveOn: microphoneAndSpeakerController
                                    .isReceiving.value,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (microphoneAndSpeakerController
                                        .isReceiving.value) {
                                      microphoneAndSpeakerController
                                          .stopSpeaking();
                                    } else {
                                      await microphoneAndSpeakerController
                                          .startSpeaking();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.speaker,
                                    color: Colors.white,
                                    size: 55.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10.0),
                                      shape: const CircleBorder(),
                                      primary: Colors.black),
                                ),
                              )),
                          Obx(() => Ripples(
                                color: Colors.blueAccent,
                                waveOn: microphoneAndSpeakerController
                                    .isRecording.value,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (microphoneAndSpeakerController
                                        .isRecording.value) {
                                      microphoneAndSpeakerController
                                          .stopRecording();
                                    } else {
                                      microphoneAndSpeakerController
                                          .startRecording();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                    size: 55.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10.0),
                                      shape: const CircleBorder(),
                                      primary: Colors.purple),
                                ),
                              )),
                        ],
                      ),
                    )
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
        return MyRoomProfile(
          user: users[index],
          isModerator: index == 0,
          isMute: index == 3,
          size: 80,
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
              // Navigator.pop(context);
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
