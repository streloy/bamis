import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/ApiURL.dart';

class AgrihubController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController = TabController(length: 2, vsync: this);
  //late dynamic tabOneCropType = [].obs; //["তৈলবীজ", "ডাল ফসল", "দানা ফসল", "ফল", "ফুল", "মসলা", "সবজি ফসল", "কন্দাল ফসল", "সামুদ্রিক শৈবাল", "পানিয়"].obs;
  var tabOneCropType = [].obs;
  var tabOneCropTypeValue = "".obs;
  var tabOneCropName = [].obs;
  var tabOneCropNameValue = "".obs;
  var tabOneCropVariety = [].obs;
  var tabOneCropVarietyValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    getCropType();
  }

  Future<void> refresh({bool value = false}) async {
    await getCropType();
  }

  Future getCropType() async {
    var response = await http.post(ApiURL.agrihub_crop_type);
    dynamic decode = jsonDecode(response.body);
    tabOneCropType.value = decode['result'];
  }

  Future getCropName(String type) async {
    tabOneCropTypeValue.value = type;
    var response = await http.post(Uri.parse("${ApiURL.agrihub_crop_name}${type}"));
    dynamic decode = jsonDecode(response.body);
    tabOneCropName.value = decode['result'];
    if(tabOneCropName.value.length > 0) {
      tabOneCropNameValue.value = tabOneCropName.value[0]['crop_name'];
    } else {
      tabOneCropNameValue.value = "";
    }
  }

  Future getCropVariety(String name) async {
    tabOneCropNameValue.value = name;
    var response = await http.post(Uri.parse("${ApiURL.agrihub_crop_variety}${name}"));
    dynamic decode = jsonDecode(response.body);
    tabOneCropVariety.value = decode['result'];
    print(decode);

    if(tabOneCropVariety.value.length > 0) {
      tabOneCropVarietyValue.value = tabOneCropVariety.value[0]['crop_variety'];
    } else {
      tabOneCropVarietyValue.value = "";
    }
    print("CROP VARIETY");
    print(decode);
  }

  setCropVariety(String name) {
    tabOneCropVarietyValue.value = name;
  }

  getTips() {


    if(tabOneCropVarietyValue.value.isNotEmpty) {
      var genurl = "${ApiURL.agrihub_webview}${tabOneCropVarietyValue.value}";
      Get.toNamed('webview', arguments: {"title": tabOneCropVarietyValue.value, "url": genurl}, );
    } else {
      Get.snackbar("Warning", "Something went wrong!");
    }
  }

}