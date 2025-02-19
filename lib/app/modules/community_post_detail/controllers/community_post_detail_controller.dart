import 'dart:convert';

import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/cupertino.dart';
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
  final userPrefService = UserPrefService();

  @override
  void onInit() {
    super.onInit();

    postData.value = Get.arguments;
    id.value = postData.value['id'];
    title.value = postData.value['title'];

    postDetail(id.value);
    postCommentList(id.value);
  }

  Future postDetail(id) async {
    token = userPrefService.userToken ?? '';

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var url = '${ApiURL.community_postdetail}?id=${id}';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    postData.value = decode['result'][0];
    print(postData.values);
    print(postData.value['post_dislike']);
  }

  Future postReaction(type, item) async {
    var like = 1;
    var dislike = 1;
    if(type == 'like') {
      like = (int.parse(item['liked']) == 1) ? 0 : 1;
      dislike = int.parse(item['disliked']);
    } else {
      like = int.parse(item['liked']);
      dislike = (int.parse(item['disliked']) == 1) ? 0 : 1;
    }

    token = userPrefService.userToken ?? '';
    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var params = jsonEncode({
      "id": int.parse(item['id']),
      "like": like,
      "dislike": dislike
    });
    var response = await http.post(Uri.parse(ApiURL.community_reaction), body: params, headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);

    if(response.statusCode == 200 ) {
      postDetail(item['id']);
    }

    Get.snackbar(
      "Reaction",
      decode['message'],
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16)
    );
  }

  Future postCommentList(id) async {
    token = userPrefService.userToken ?? '';

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var url = '${ApiURL.community_postcomments}?id=${id}';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    postComments.value = decode['result'];
  }

  Future commentSubmit() async{
    token = await UserPrefService().userToken ?? '';

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var authId = userPrefService.userId;
    var postId = id.value;
    var comment = commentController.text;
    var params = jsonEncode({
      "authId": "${authId}",
      "postId": '${postId}',
      "comment": "${comment}"
    });
    var response = await http.post(Uri.parse(ApiURL.community_postcommentsubmit), body: params, headers: requestHeaders);
    dynamic decode = jsonDecode(response.body) ;
    if(response.statusCode != 200) {
      return Get.defaultDialog(
          title: "Alert",
          middleText: decode['message'],
          textCancel: 'Ok'
      );
    }
    commentController.text = "";
    postCommentList(postId);
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
