import 'dart:convert';
import 'dart:ui';

import 'package:bamis/utils/UserPrefService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/ApiURL.dart';

class TaskReminderController extends GetxController {
  //TODO: Implement TaskReminderController
  var isLoading = false.obs;
  var tasks = [].obs;

  @override
  void onInit() {
    super.onInit();

    getMasterInfo();
  }

  Future getMasterInfo() async {
    isLoading.value = true;
    var token = await UserPrefService().userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.get(Uri.parse("${ApiURL.mycrops_taskreminder}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(response.statusCode != 200) {
      Get.snackbar("Warning", decode['message']);
    }
    tasks.value = decode['result'];
    isLoading.value = false;
  }

  Color getCardColor(String item) {
    if(item == 'advice') {
      return Color(0xFFE1FFDF);
    } else if(item == 'procedure') {
      return Color(0xFFFFF3BB);
    } else if(item == 'hint') {
      return Color(0xFFFFEBD8);
    } else {
      return Color(0xFFB2B2B2);
    }
  }

}
