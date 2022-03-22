import 'dart:core';
import 'package:cron/cron.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_client/utils/utils.dart';

class LocalStorageKeys {
  static const userEmail = "userEmail";
  static const jwt = "jwt";
}

class VariableControllr extends GetxController {
  String ourUUID = "";
  final cron = Cron();

  RxList<String> currentUsersUUID = RxList(['a', 'b', 'c', 'd']);
  String? jwt;
  String? accessToken;

  SharedPreferences? preferences;

  Future<void> initilizeFunction() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    preferences = await _prefs;

    jwt = preferences?.getString(LocalStorageKeys.jwt);

    ourUUID = await getUniqueDeviceId();
  }

  Future<void> saveJwt(String? jwt) async {
    if (jwt != null && jwt != "") {
      this.jwt = jwt;
      await preferences?.setString(LocalStorageKeys.jwt, jwt);
    }
  }
}
