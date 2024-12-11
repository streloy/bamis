import 'dart:convert';

import 'package:bamis/app/modules/community_post_detail/bindings/community_post_detail_binding.dart';
import 'package:bamis/app/modules/community_post_detail/views/community_post_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/ApiURL.dart';

class CommunityController extends GetxController {
  ScrollController scrollController = ScrollController();
  var post = [].obs;
  var post_count = 0.obs;


  @override
  void onInit() {
    // getPost(0, 10);
    // scrollController.addListener((){
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
    //     getPost(post.value.length, 10);
    //   }
    // });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future getPost(offset, limit) async {
    var url = '${ApiURL.community_post}?offset=${offset}&limit=${limit}';
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);
    post.value.addAll(decode['result']);
    post_count.value = int.parse(decode['count']);

    print(url);
    // print(post.value.length);
    //print(post.value);

  }

  openDetailViewPage(dynamic item) {
    Get.to(CommunityPostDetailView(), binding: CommunityPostDetailBinding(), arguments: {"id": item['id'], "title": item['title'] }, transition: Transition.rightToLeft);
  }

}