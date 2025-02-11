import 'dart:convert';
import 'dart:ui';

import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';
import '../../mycrop_add/bindings/mycrop_add_binding.dart';
import '../../mycrop_add/views/mycrop_add_view.dart';

class CropAdvisoryController extends GetxController {
  //TODO: Implement CropAdvisoryController

  var isupdate = "";
  var crops = [].obs;

  @override
  void onInit() {
    super.onInit();

    getMasterInfo();
  }

  Future gotoAddCrop() async{
    var result = await Get.to(()=> MycropAddView(), binding: MycropAddBinding(), transition: Transition.rightToLeft);
    if(result == 'update') {
      getMasterInfo();
    }
  }

  Future getMasterInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("TOKEN");
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.get(Uri.parse("${ApiURL.mycrops_crops}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    crops.value = decode['result'];
  }

  Future deleteMyCrop(crop_id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("TOKEN");
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.delete(Uri.parse("${ApiURL.mycrops_crops}?crop=${crop_id}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(response.statusCode == 200) {
      Get.snackbar(
        "Message",
        decode['message'],
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
      );
      await getMasterInfo();
    }

  }

}
