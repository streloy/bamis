import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/ApiURL.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';

class OtpController extends GetxController {

  final mobile = Get.arguments['mobile'] ?? "";
  final TextEditingController otp = TextEditingController();

  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  late Timer timer;
  var second = 0.obs;
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    timer = new Timer.periodic(Duration(seconds: 1), (Timer t){
      second.value = 120 - t.tick;
      if(t.tick >= 120) {
        second.value = 0;
        timer.cancel();
      }
    });
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    timer.cancel();
  }

  Future loginClick() async{
    if(!checkLoginButtonStatus()) {
      return Get.defaultDialog(
          title: "Alert",
          middleText: "All opt input need to submit!",
          textCancel: 'Ok'
      );
    }
    var params = jsonEncode({
      "mobile": "${mobile}",
      "otp": '${otp1.text}${otp2.text}${otp3.text}${otp4.text}',
      "device": "android"
    });
    var response = await http.post(ApiURL.otpcheck, body: params);
    dynamic decode = jsonDecode(response.body) ;
    if(response.statusCode != 200) {
      return Get.defaultDialog(
          title: "Alert",
          middleText: decode['message'],
          textCancel: 'Ok'
      );
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('TOKEN', decode['token']);
    prefs.setString('ID', decode['result']['id']);
    prefs.setString('NAME', decode['result']['fullname']);
    prefs.setString('EMAIL', decode['result']['email']);
    prefs.setString('MOBILE', decode['result']['mobile']);
    prefs.setString('ADDRESS', decode['result']['address']);
    prefs.setString('PHOTO', decode['result']['photo']);

    // FCM INSERT
    var body = jsonEncode({
      "fcm": prefs.getString("FCM"),
      "device": "android"
    });
    await http.post(ApiURL.fcm, body: body, headers: { HttpHeaders.authorizationHeader: '${decode['token']}' } );
    Get.offAll(HomeView(), transition: Transition.downToUp, binding: HomeBinding());
  }

  Future resendOTP() async {
    var params = jsonEncode({
      "mobile": "${mobile}"
    });
    var response = await http.post(ApiURL.mobile, body: params);
    dynamic decode = jsonDecode(response.body) ;
    if(response.statusCode != 200) {
      return Get.defaultDialog(
          title: "Alert",
          middleText: decode['message'],
          textCancel: 'Ok'
      );
    }

    timer = new Timer.periodic(Duration(seconds: 1), (Timer t){
      second.value = 120 - t.tick;
      if(t.tick >= 120) {
        second.value = 0;
        timer.cancel();
      }
    });
  }

  bool checkLoginButtonStatus() {
    if (otp1.text == '' || otp2.text == '' || otp3.text == '' || otp4.text == '') {
      return false;
    } else {
      return true;
    }
  }

}