import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/ApiURL.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';

class LoginController extends GetxController {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  login() {
    Get.offAll(HomeView(), transition: Transition.downToUp, binding: HomeBinding());
  }

  Future loginClick() async{
    print("SAIM LOGIN CHECK");
    var params = jsonEncode({
      "email": "${email.value.text}",
      "password": "${password.value.text}",
      "device": "android"
    });
    var response = await http.post(ApiURL.login, body: params);
    dynamic decode = jsonDecode(response.body) ;
    print(decode);
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
    prefs.setString('PHOTO', decode['result']['photo']);

    Get.offAll(HomeView(), transition: Transition.downToUp, binding: HomeBinding());
  }

  @override
  void onInit() {
    super.onInit();
  }
}