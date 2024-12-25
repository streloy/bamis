import 'dart:convert';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../utils/ApiURL.dart';

class CropDiseaseStagesController extends GetxController {
  //TODO: Implement CropDiseaseStagesController

  var mycropsstage = [].obs;
  late dynamic item;

  @override
  void onInit() {
    super.onInit();

    item = Get.arguments;
    getMyCropStage(item);
  }

  Future getMyCropStage(dynamic item) async {
    print(item);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("TOKEN");
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse("${ApiURL.mycrops_mycropstage}?id=${item['id']}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    mycropsstage.value = decode['result'];
  }

  Color getStageCardColor(String item) {
    if(item == 'completed') {
      return Color(0xFFE1FFDF);
    } else if(item == 'ongoing') {
      return Color(0xFFFFF3BB);
    } else if(item == 'upcoming') {
      return Color(0xFFB2B2B2);
    } else {
      return Color(0xFFB2B2B2);
    }
  }

}
