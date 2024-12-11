import 'dart:convert';

import 'package:get/get.dart';

import '../../../../utils/ApiURL.dart';
import 'package:http/http.dart' as http;

class ImportantVideoController extends GetxController {
  //TODO: Implement ImportantVideoController

  var videoList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVideoList();
  }

  Future getVideoList() async {
    var url = "${ApiURL.important_video_list}";
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);
    videoList.value = decode['result'];
  }

  Future openYoutube(item) async {
    await Get.toNamed('ytplayer', arguments: item);
  }

}
