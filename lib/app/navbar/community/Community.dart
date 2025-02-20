import 'dart:convert';

import 'package:bamis/app/modules/community_post_add/bindings/community_post_add_binding.dart';
import 'package:bamis/app/modules/community_post_add/views/community_post_add_view.dart';
import 'package:bamis/app/modules/community_post_my/bindings/community_post_my_binding.dart';
import 'package:bamis/app/modules/community_post_my/views/community_post_my_view.dart';
import 'package:bamis/app/navbar/community/CommunityController.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../../../utils/ApiURL.dart';
import '../../../utils/connectivity_service.dart';
import '../../modules/community_post_detail/bindings/community_post_detail_binding.dart';
import '../../modules/community_post_detail/views/community_post_detail_view.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> with RouteAware {
  final NetworkController networkController = Get.put(NetworkController());
  final controller = Get.put(CommunityController());
  final userPrefService = UserPrefService();
  ScrollController scrollController = ScrollController();
  List<dynamic> mainpost = [];
  List<dynamic> post = [];
  int post_count = 0;
  var token = "";
  var lang = Get.locale?.languageCode;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPost(0, 10);
    scrollController.addListener((){
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        getPost(post.length, 10);
      }
    });
  }

  openDetailViewPage(dynamic item) {
    var result = Get.to(()=> CommunityPostDetailView(), binding: CommunityPostDetailBinding(), arguments: item, transition: Transition.rightToLeft);
    if(result == 'update') {
      onRefresh();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future postReaction(type, item, index) async {
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
      setState(() {
        if(like == 1 && type == 'like') {
          post[index]['post_like'] = (int.parse(post[index]['post_like']) + 1).toString();
        } else if(like == 0 && type == 'like') {
          post[index]['post_like'] = (int.parse(post[index]['post_like']) - 1).toString();
        }

        if(dislike == 1 && type == 'dislike') {
          post[index]['post_dislike'] = (int.parse(post[index]['post_dislike']) + 1).toString();
        } else if(dislike == 0 && type == 'dislike') {
          post[index]['post_dislike'] = (int.parse(post[index]['post_dislike']) - 1).toString();
        }

        post[index]['liked'] = "${like}";
        post[index]['disliked'] = "${dislike}";
      });
    }

    Get.snackbar(
        "Reaction",
        decode['message'],
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16)
    );
  }

  Future getPost(offset, limit) async {
    token = userPrefService.userToken ?? '';

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = '${ApiURL.community_post}?offset=${offset}&limit=${limit}';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);

    setState(() {
      mainpost.addAll(decode['result']);
      post = mainpost;
      post_count = int.parse(decode['count']);
    });
  }

  Future onRefresh() async {
    setState(() {
      mainpost = [];
      post = [];
      getPost(0, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return networkController.isNetworkWorking.value ?
    Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.forum_rounded),
        titleSpacing: 0,
        title: Text("community_title".tr, style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(onPressed: (){ Get.to(()=> CommunityPostMyView(), binding: CommunityPostMyBinding(), transition: Transition.rightToLeft); }, icon: Icon(Icons.list_alt_outlined)),
          IconButton(onPressed: (){ Get.to(()=> CommunityPostAddView(), binding: CommunityPostAddBinding(), transition: Transition.rightToLeft); }, icon: Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "community_promot".tr,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors().app_primary),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors().app_primary_dark),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors().app_natural_white,
                    ),
                    child: TextFormField(
                      controller: searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            searchController.text = "";
                          });
                        }, icon: Icon(Icons.cancel))
                      ),
                      onChanged: (text) {
                        setState(() {
                          post = mainpost.where((item) =>item['title'].toLowerCase().contains(text.toLowerCase())).toList();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            // Container(
            //   height: 300,
            //   child:
            // )

            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: post.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  dynamic postData = post[index];
                  if(index < (post_count)) {
                    return GestureDetector(
                      onTap: () {
                        openDetailViewPage(postData);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 0, right: 0, top: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            color: AppColors().app_natural_white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 24.0,
                                backgroundImage:
                                NetworkImage(postData['photo']),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(postData['fullname']),
                              subtitle: Text(postData['created_at']),
                              trailing: IconButton(onPressed: () { Share.share(postData['url']); }, icon: Icon(Icons.share)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(postData['title'], maxLines: 2, style: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                            Image.network( postData['cover'], height: 200, width: double.infinity, fit: BoxFit.cover),
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(postData['post_like'] + " Upvote", style: TextStyle(fontSize: 12)),
                                  Text(postData['post_dislike'] + " Downvote", style: TextStyle(fontSize: 12)),
                                  Text(postData['post_comments'] + " Comments", style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () { postReaction('like', postData, index); },
                                  icon: postData['liked'] == '1' ? Icon(Icons.thumb_up, size: 14) : Icon(Icons.thumb_up_outlined, size: 14),
                                  label: Text("Upvote", style: TextStyle(fontSize: 12)),
                                ),
                                TextButton.icon(
                                  onPressed: () { postReaction('dislike', postData, index); },
                                  icon: postData['disliked'] == '1' ? Icon(Icons.thumb_down, size: 14) : Icon(Icons.thumb_down_outlined, size: 14),
                                  label: Text("Downvote", style: TextStyle(fontSize: 12)),
                                ),
                                TextButton.icon(
                                  onPressed: () { openDetailViewPage(postData); },
                                  icon: Icon(Icons.forum_outlined, size: 14),
                                  label: Text("Comments", style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    if(index != (post_count-1)) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ):
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset('assets/no_internet.png', width: 150,)),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: (){
              getPost(0,10);
            },
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
