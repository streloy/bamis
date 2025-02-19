import 'dart:convert';

import 'package:bamis/utils/UserPrefService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class CropAdviosryStageDetailController extends GetxController {
  //TODO: Implement CropAdviosryStageDetailController

  late dynamic item;
  var stagedetail = [].obs;

  @override
  void onInit() {
    super.onInit();

    item = Get.arguments;
    getMyCropStageDetail(item);
  }

  Future getMyCropStageDetail(dynamic item) async {
    var token = await UserPrefService().userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse("${ApiURL.mycrops_mycropstagedetail_advisory}?cid=${item['cropId']}&stage=${item['stageOrder']}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    print(decode);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    stagedetail.value = decode['result'];
  }

}
