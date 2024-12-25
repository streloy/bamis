import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class CropDiseaseController extends GetxController {
  //TODO: Implement CropDiseaseController

  var crops = [].obs;

  @override
  void onInit() {
    super.onInit();

    getMasterInfo();
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
}
