import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class CropDiseaseStagesDetailController extends GetxController {
  //TODO: Implement CropDiseaseStagesDetailController

  late dynamic item;
  var stagedetail = [].obs;

  @override
  void onInit() {
    super.onInit();

    item = Get.arguments;
    getMyCropStageDetail(item);
  }

  Future getMyCropStageDetail(dynamic item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("TOKEN");
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.get(Uri.parse("${ApiURL.mycrops_mycropstagedetail_disease}?cid=${item['cropId']}&stage=${item['stageOrder']}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    print(decode);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    stagedetail.value = decode['result'];
    print(stagedetail.value);
  }


}
