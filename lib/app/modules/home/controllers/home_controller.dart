import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';
import '../../../auth/mobile/Mobile.dart';
import '../../../navbar/agrihub/Agrihub.dart';
import '../../../navbar/community/Community.dart';
import '../../../navbar/dashboard/Dashboard.dart';
import '../../../navbar/profile/Profile.dart';
import '../../../navbar/scan/Scan.dart';

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
    // var token = prefs.getString("TOKEN");
    if(prefs.getString("TOKEN") == null || prefs.getString("TOKEN") == "") {
      Get.offAll(Mobile(), transition: Transition.downToUp);
    } else {
      var body = jsonEncode({
        "fcm": prefs.getString("FCM"),
        "device": "android"
      });
      await http.post(ApiURL.fcm, body: body, headers: { HttpHeaders.authorizationHeader: '${prefs.getString("TOKEN")}' } );
    }
  }


}
