import 'package:flutter_client/models/room.dart';
import 'package:flutter_client/models/user.dart';
import 'package:flutter_client/pages/room/my_chat_room_page.dart';
import 'package:flutter_client/pages/room/room_list.dart';
import 'package:flutter_client/pages/welcome/email_page.dart';
import 'package:flutter_client/pages/welcome/verify_page.dart';
import 'package:flutter_client/pages/welcome/welcome_page.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/util/style.dart';
import 'package:flutter_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  () async {
    variableController.initilizeFunction();

    runApp(GetMaterialApp(
      initialRoute: RoutesMap.welcome,
      getPages: [
        GetPage(name: RoutesMap.welcome, page: () => const WelcomePage()),
        GetPage(name: RoutesMap.register, page: () => const EmailPage()),
        GetPage(
            name: RoutesMap.registerVerifying, page: () => const VerifyPage()),
        GetPage(name: RoutesMap.roomList, page: () => const RoomListPage()),
        // GetPage(name: RoutesMap.chatRoom, page: () => SingleChatRoomPage()),
      ],
    ));
  }();
}

// const userNumbersInThisRoom = 4;

// String getARandomCatPicturePath() {
//   return 'assets/images/cat${getARandomNumber(1, userNumbersInThisRoom)}.jpg';
// }

// class SingleChatRoomPage extends StatefulWidget {
//   const SingleChatRoomPage({Key? key}) : super(key: key);

//   @override
//   _SingleChatRoomPageState createState() => _SingleChatRoomPageState();
// }

// class _SingleChatRoomPageState extends State<SingleChatRoomPage> {
//   @override
//   void initState() {
//     super.initState();

//     () async {
//       await microphoneAndSpeakerController.initilizeFunction();
//     }();

//     variableController.cron.schedule(Schedule(seconds: "*/1"), () async {
//       // print('every 1 minutes');
//       var newUUIDlist = await grpcController.getCurrentUserUUIDlist();

//       for (var uuid in newUUIDlist) {
//         if (!variableController.currentUsersUUID.contains(uuid)) {
//           variableController.currentUsersUUID.add(uuid);
//         }
//       }

//       for (var uuid in variableController.currentUsersUUID) {
//         if (!newUUIDlist.contains(uuid)) {
//           variableController.currentUsersUUID.remove(uuid);
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Clubhouse UI Clone',
//         theme: ThemeData(
//           scaffoldBackgroundColor: Style.LightBrown,
//           appBarTheme: const AppBarTheme(
//             color: Style.LightBrown,
//             elevation: 0.0,
//             iconTheme: IconThemeData(
//               color: Colors.black,
//             ),
//           ),
//         ),
//         home: Obx(() {
//           Room myRoom = Room.fromJson({
//             'title': "yingshaoxo's chat room",
//             "users": variableController.currentUsersUUID
//                 .map((uuid) => User.fromJson({
//                       'name': uuid.substring(0, 8),
//                       'profileImage': getARandomCatPicturePath()
//                     }))
//                 .toList(),
//             'speakerCount': variableController.currentUsersUUID.length,
//           });

//           return RoomPage(
//             room: myRoom,
//           );
//         })
//         // home: WelcomePage(),
//         );
//   }
// }
