import 'package:flutter_client/models/room.dart';
import 'package:flutter_client/models/user.dart';
import 'package:flutter_client/pages/room/room_list.dart';
import 'package:flutter_client/pages/room/single_room.dart';
import 'package:flutter_client/pages/room/single_voice_room.dart';
import 'package:flutter_client/pages/welcome/email_page.dart';
import 'package:flutter_client/pages/welcome/verify_page.dart';
import 'package:flutter_client/pages/welcome/welcome_page.dart';
import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/utils/style.dart';
import 'package:flutter_client/utils/utils.dart';
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
        GetPage(
            name: RoutesMap.singleRoomPage,
            page: () => const SingleVoiceRoom()),
      ],
    ));
  }();
}
