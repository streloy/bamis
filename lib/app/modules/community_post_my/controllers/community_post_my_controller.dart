import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/ApiURL.dart';

class CommunityPostMyController extends GetxController {
  //TODO: Implement CommunityPostMyController

  var token = "".obs;
  var lang = Get.locale?.languageCode;
  var post = [].obs;

  @override
  void onInit() {
    super.onInit();

    getPost();
  }

  Future getPost() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token.value = sharedPreferences.getString("TOKEN")!;

    Map<String, String> requestHeaders = {
      'Authorization': token.value.toString(),
      'Accept-Language': lang.toString()
    };

    var url = '${ApiURL.community_mypost}';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    post.value = decode['result'];
  }
}
