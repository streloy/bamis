import 'dart:convert';
import 'dart:io';

import 'package:bamis/app/auth/login/Login.dart';
import 'package:bamis/app/auth/mobile/Mobile.dart';
import 'package:bamis/app/navbar/community/Community.dart';
import 'package:bamis/app/navbar/agrihub/Agrihub.dart';
import 'package:bamis/app/navbar/dashboard/Dashboard.dart';
import 'package:bamis/app/navbar/profile/Profile.dart';
import 'package:bamis/app/navbar/scan/Scan.dart';
import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  static HomeController get to => Get.find();

  final count = 0.obs;
  var currentTab = 0.obs;
  final List<Widget> screen = [
    Dashboard(),
    Agrihub(),
    Community(),
    Profile(),
    Scan()
  ];
  final userPrefService = UserPrefService();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onItemTapped(index) {
    currentTab.value = index;
  }

  void changePage(int index) {
    currentTab.value = index;
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('shakil token: ${userPrefService.userToken}');
    if(userPrefService.userToken == null || userPrefService.userToken == "") {
      Get.offAll(Mobile(), transition: Transition.downToUp);
    } else {
      var body = jsonEncode({
        "fcm": userPrefService.fcmToken,
        "device": "android"
      });
      var response = await http.post(ApiURL.fcm, body: body, headers: { HttpHeaders.authorizationHeader: '${userPrefService.userToken}' } );
    }
  }


}
