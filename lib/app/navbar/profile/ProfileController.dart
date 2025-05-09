import 'dart:convert';
import 'dart:io';
import 'package:bamis/app/auth/mobile/Mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/ApiURL.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController = TabController(length: 3, vsync: this);

  Future logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(ApiURL.fcm, headers: { HttpHeaders.authorizationHeader: '${prefs.getString('TOKEN')}' } );
    dynamic decode = jsonDecode(response.body) ;

    Get.defaultDialog(
        title: "Alert",
        middleText: decode['message'],
        textCancel: 'OK',
        onCancel: () async {
          await prefs.remove("TOKEN");
          await prefs.remove("ID");
          await prefs.remove("NAME");
          await prefs.remove("EMAIL");
          await prefs.remove("MOBILE");
          await prefs.remove("ADDRESS");
          await prefs.remove("PHOTO");
          Get.offAll(Mobile(), transition: Transition.upToDown);
        }
    );
  }

  late var id = "".obs;
  late var name = "".obs;
  late var mobile = "".obs;
  late var email = "".obs;
  late var address = "".obs;
  late var photo = "${ApiURL.base_url_image}assets/auth/profile.jpg".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getSharedPrefData();
  }

  Future getSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = (await prefs.getString("ID"))!;
    name.value = (await prefs.getString("NAME"))!;
    mobile.value = (await prefs.getString("MOBILE"))!;
    email.value = (await prefs.getString("EMAIL"))!;
    address.value = (await prefs.getString("ADDRESS"))!;
    photo.value = ApiURL.base_url_image + (await prefs.getString("PHOTO"))!;

    nameController.text = name.value;
    emailController.text = email.value;
    addressController.text = address.value;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future updateProfile() async {
    var params = jsonEncode({
      "id": "${id.value}",
      "fullname": "${nameController.text}",
      "email": "${emailController.text}",
      "address": "${addressController.text}"
    });
    var response = await http.put(ApiURL.profile, body: params);
    dynamic decode = jsonDecode(response.body) ;

    if(response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('NAME', nameController.text);
      prefs.setString('EMAIL', emailController.text);
      prefs.setString('ADDRESS', addressController.text);
      name.value = nameController.text;
    }

    return Get.defaultDialog(
        title: "Alert",
        middleText: decode['message'],
        textCancel: 'Ok'
    );
  }

  List<bool> selectedLanguage = [false, true].obs;
  Future changeLanguage(int index) async {
    for (int buttonIndex = 0; buttonIndex < selectedLanguage.length; buttonIndex++) {
      if (buttonIndex == index) {
        selectedLanguage[buttonIndex] = true;
      } else {
        selectedLanguage[buttonIndex] = false;
      }
    }
    if(index == 0) {
      await Get.updateLocale(Locale('en', 'US'));
    } else {
      await Get.updateLocale(Locale('bn', 'BD'));
    }
  }

}