import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/ApiURL.dart';

class PestDiseaseAlertsController extends GetxController {
  //TODO: Implement PestDiseaseAlertsController

  var cropValue = "".obs;
  var cropList = [].obs;
  var diseaseList = [].obs;

  var token = "";
  var lang = Get.locale?.languageCode;

  @override
  void onInit() {
    getInitialData();

    super.onInit();
  }

  Future getInitialData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("TOKEN")!;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = "${ApiURL.disease_crops}";
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    cropList.value = decode['result'];
    cropValue.value = cropList[0]['value'];
    changeCrop(cropValue.value);
  }

  Future changeCrop(item) async{
    print(item);
    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = "${ApiURL.disease_diseases}?crop=${item}";
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    diseaseList.value = decode['result'];
  }

  Future openDetailPage(item) async {
    Get.toNamed("pest-disease-alert-detail", arguments: item);
  }

}
