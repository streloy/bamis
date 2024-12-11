import 'dart:convert';

import 'package:bamis/app/navbar/community/CommunityController.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/ApiURL.dart';
import '../../modules/community_post_detail/bindings/community_post_detail_binding.dart';
import '../../modules/community_post_detail/views/community_post_detail_view.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final controller = Get.put(CommunityController());

  ScrollController scrollController = ScrollController();
  List<dynamic> post = [];
  int post_count = 0;

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
    Get.to(CommunityPostDetailView(), binding: CommunityPostDetailBinding(), arguments: {"id": item['id'], "title": item['title'] }, transition: Transition.rightToLeft);
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

    setState(() {
      post.addAll(decode['result']);
      post_count = int.parse(decode['count']);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.forum_rounded),
        titleSpacing: 0,
        title: Text("Community", style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "Welcome to the BAMIS Community",
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
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Search...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.cancel)
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 4, right: 16),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: AppColors().app_primary_dark),
              //     borderRadius: BorderRadius.circular(8),
              //     color: AppColors().app_natural_white,
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.all(12),
              //     child: Icon(Icons.search_rounded),
              //   ),
              // ),
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
                print("INDEX: ${index}");
                dynamic postData = post[index];
                if(index < (post_count)) {
                  return GestureDetector(
                    onTap: () {
                      print("SAIM");
                      openDetailViewPage(postData);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      padding: EdgeInsets.only(top: 4, bottom: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors().app_primary_bg_dark),
                      child: Column(
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
                            trailing: Icon(Icons.more_vert_outlined),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(postData['title'] +
                                    ", " +
                                    postData['id']),
                                SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                      postData['cover'],
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(postData['post_like'] +
                                        " Upvote"),
                                    Text("•", style: TextStyle(fontSize: 20)),
                                    Text(postData['post_like'] +
                                        " Downvote"),
                                    Text("•", style: TextStyle(fontSize: 20)),
                                    Text(postData['post_like'] +
                                        " Comments"),
                                  ],
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.thumb_up_outlined),
                                            Text("Upvote")
                                          ],
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.thumb_down_outlined),
                                            Text("Downvote")
                                          ],
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.forum_outlined),
                                            Text("Upvote")
                                          ],
                                        ))
                                  ],
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                ),
                              ],
                            ),
                          )
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
    );
  }
}
