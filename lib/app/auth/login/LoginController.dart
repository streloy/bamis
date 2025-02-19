import 'dart:convert';

import 'package:bamis/app/modules/home/bindings/home_binding.dart';
import 'package:bamis/app/modules/home/views/home_view.dart';
import 'package:bamis/utils/ApiURL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/UserPrefService.dart';

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

    await UserPrefService().saveUserData(
        decode['token'],
        decode['result']['id'],
        decode['result']['fullname'],
        decode['result']['email'],
        decode['result']['mobile'],
        decode['result']['address'],
        decode['result']['photo']
    );

    Get.offAll(HomeView(), transition: Transition.downToUp, binding: HomeBinding());
  }

  @override
  void onInit() {

  }
}