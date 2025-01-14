import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class CommunityPostDetailController extends GetxController {
  //TODO: Implement CommunityPostDetailController

  var id = "".obs;
  var title = "".obs;
  var postData = {}.obs;
  var postComments = [].obs;
  var token = "";
  var lang = Get.locale?.languageCode;
  TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    dynamic decode = Get.arguments;
    id.value = decode['id'];
    title.value = decode['title'];

    getPostInfo(id.value);
  }

  Future getPostInfo(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("TOKEN")!;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = '${ApiURL.community_postdetail}?id=${id}';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(decode['result'].length < 1) {
      return;
    }
    postData.value = decode['result'][0];

    var urlcomments = '${ApiURL.community_postcomments}?id=${id}';
    var responsecomments = await http.get(Uri.parse(urlcomments));
    dynamic decodecomments = jsonDecode(responsecomments.body);
    postComments.value = decodecomments['result'] ?? [];
  }

  Future commentSubmit() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("TOKEN")!;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var authId = prefs.getString("ID");
    var postId = id.value;
    var comment = commentController.text;
    var params = jsonEncode({
      "authId": "${authId}",
      "postId": '${postId}',
      "comment": "${comment}"
    });
    print(params);
    var response = await http.post(Uri.parse(ApiURL.community_postcommentsubmit), body: params, headers: requestHeaders);
    dynamic decode = jsonDecode(response.body) ;
    print(decode);
    if(response.statusCode != 200) {
      return Get.defaultDialog(
          title: "Alert",
          middleText: decode['message'],
          textCancel: 'Ok'
      );
    }
    commentController.text = "";
    getPostInfo(postId);
  }

}
