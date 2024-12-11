import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class BulletinsController extends GetxController {
  //TODO: Implement BulletinsController

  var bulletinCategory = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getBulletinCategory();
  }

  Future getBulletinCategory() async{
    var response = await http.get(Uri.parse(ApiURL.bulltin_category));
    dynamic decodeTag = jsonDecode(response.body);
    bulletinCategory.value = decodeTag['result'];
  }

  Future openBulletinList(item) async{
    Get.toNamed(item['route'], arguments: item);
  }

}
