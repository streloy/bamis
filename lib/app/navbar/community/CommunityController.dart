import 'dart:convert';

import 'package:bamis/app/modules/community_post_detail/bindings/community_post_detail_binding.dart';
import 'package:bamis/app/modules/community_post_detail/views/community_post_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/ApiURL.dart';
import '../../../utils/UserPrefService.dart';

class CommunityController extends GetxController {
  final userPrefService = UserPrefService();
  var posts = <dynamic>[].obs;
  var postCount = 0.obs;
  var mainPosts = <dynamic>[].obs;
  var token = "";
  var lang = Get.locale?.languageCode;
  var isLoading = false.obs;
  ScrollController scrollController = ScrollController();


  @override
  void onInit() {
    token = userPrefService.userToken ?? '';
    lang = Get.locale?.languageCode;
    getPosts(0, 10);
    scrollController.addListener((){
      _scrollListener();
    });
  }

  void _scrollListener(){
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getPosts(posts.length, 10);
    }
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getPosts(int offset, int limit) async {
    isLoading.value = true;
    try {
      var url = '${ApiURL.community_post}?offset=$offset&limit=$limit';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': token,
        'Accept-Language': lang ?? 'en',
      });
      var decode = jsonDecode(response.body);
      mainPosts.addAll(decode['result']);
      posts.value = mainPosts;
      postCount.value = int.parse(decode['count']);
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPosts() async {
    mainPosts.clear();
    posts.clear();
    await getPosts(0, 10);
  }

  void searchPosts(String text) {
    posts.value = mainPosts
        .where((item) =>
        item['title'].toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  Future<void> handleReaction(String type, dynamic item, int index) async {
    var like = type == 'like' ? (int.parse(item['liked']) == 1 ? 0 : 1) : int.parse(item['liked']);
    var dislike = type == 'dislike' ? (int.parse(item['disliked']) == 1 ? 0 : 1) : int.parse(item['disliked']);

    var params = jsonEncode({
      "id": int.parse(item['id']),
      "like": like,
      "dislike": dislike,
    });

    var response = await http.post(Uri.parse(ApiURL.community_reaction),
        body: params,
        headers: {
          'Authorization': token,
          'Accept-Language': lang ?? 'en',
        });

    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      posts[index]['post_like'] = like == 1
          ? (int.parse(posts[index]['post_like']) + 1).toString()
          : (int.parse(posts[index]['post_like']) - 1).toString();
      posts[index]['post_dislike'] = dislike == 1
          ? (int.parse(posts[index]['post_dislike']) + 1).toString()
          : (int.parse(posts[index]['post_dislike']) - 1).toString();
      posts[index]['liked'] = "$like";
      posts[index]['disliked'] = "$dislike";
    }
    Get.snackbar("Reaction", decode['message'],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16));
  }

  openDetailViewPage(dynamic item) {
    var result = Get.to(()=> CommunityPostDetailView(), binding: CommunityPostDetailBinding(), arguments: item, transition: Transition.rightToLeft);
    if(result == 'update') {
      refreshPosts();
    }
  }
}