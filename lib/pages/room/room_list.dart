import 'package:flutter_client/generated_grpc/room_control_service.pb.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/store/variable_controller.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter_client/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  List<RoomInfo> rooms = [];

  @override
  void initState() {
    super.initState();

    () async {
      rooms = await roomControlGrpcControllr.getRoomList();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.only(
          top: 120,
          left: 50,
          right: 50,
          bottom: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              child: buildContents(),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                  color: Style.AccentBlue,
                  onPressed: () {
                    showCreateRoomDialog(context: context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Create a room',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return InkWell(
      onTap: () async {
        await roomControlGrpcControllr.test();
      },
      child: const Text(
        '🎉 Rooms!',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }

  Widget buildContents() {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color.fromARGB(
                255, 244, 237, 226), // but now it should be declared like this
          ),
        ),
        child: rooms.isEmpty
            ? const Center(
                child: Text(
                  'Nice, you are the first one here!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            : ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(rooms[index].roomName),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ));
  }

  void showCreateRoomDialog({required BuildContext context}) {
    TextEditingController roomNameInputController = TextEditingController();

    Alert(
        context: context,
        title: "Create a room",
        content: Column(
          children: <Widget>[
            TextField(
              controller: roomNameInputController,
              // textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.house),
                labelText: '',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              String roomName = roomNameInputController.text;

              if (roomName.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Please enter a valid room name',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }

              bool success =
                  await roomControlGrpcControllr.createRoom(roomName: roomName);
              if (success) {
                String? accessToken = await roomControlGrpcControllr
                    .getAccessToARoom(roomName: roomName);
                if (accessToken != null) {
                  variableController.accessToken = accessToken;

                  Navigator.pop(context);
                  Get.toNamed(RoutesMap.singleRoomPage);
                  Fluttertoast.showToast(
                      msg: "You just created a room: $roomName",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
              } else {
                Fluttertoast.showToast(
                    msg: "Fail to create a room: $roomName",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              Navigator.pop(context);
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
