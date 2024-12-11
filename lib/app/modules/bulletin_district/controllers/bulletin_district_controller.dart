import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class BulletinDistrictController extends GetxController {
  //TODO: Implement BulletinDistrictController

  var title = "".obs;
  var bulletinLocationValue = "12".obs;
  var bulletinLocation = [].obs;
  var bulletinListCurrent = [].obs;
  var bulletinListArchive = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dynamic decode = Get.arguments;
    title.value = decode['name_bn'];

    getLocationList();
  }

  Future getLocationList() async {
    var url = "${ApiURL.bulltin_location}";
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);
    bulletinLocation.value = decode['result'];
    bulletinLocationValue.value = bulletinLocation.value[0]['id'];
    getBulletinList(bulletinLocation.value[0]['id']);
  }

  Future getBulletinList(id) async {
    var url = "${ApiURL.bulltin_list}?category=2&location=${id}&type=Current";
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);
    bulletinListCurrent.value = decode['result'];

    var url2 = "${ApiURL.bulltin_list}?category=2&location=${id}&type=Archive";
    var response2 = await http.get(Uri.parse(url2));
    dynamic decode2 = jsonDecode(response2.body);
    bulletinListArchive.value = decode2['result'];
  }

  changeLocation(id){
    bulletinLocationValue.value = id;
    getBulletinList(id);
  }


}
