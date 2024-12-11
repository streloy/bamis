import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class BulletinSpecialController extends GetxController {
  //TODO: Implement BulletinSpecialController

  var title = "".obs;
  var bulletinListCurrent = [].obs;
  var bulletinListArchive = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dynamic decode = Get.arguments;
    title.value = decode['name_bn'];

    getBulletinList();
  }

  Future getBulletinList() async {
    var url = "${ApiURL.bulltin_list}?category=3&location=0&type=Current";
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);
    bulletinListCurrent.value = decode['result'];

    var url2 = "${ApiURL.bulltin_list}?category=3&location=0&type=Archive";
    var response2 = await http.get(Uri.parse(url2));
    dynamic decode2 = jsonDecode(response2.body);
    bulletinListArchive.value = decode2['result'];
  }


}
