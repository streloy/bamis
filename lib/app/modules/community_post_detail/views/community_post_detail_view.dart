import 'package:bamis/utils/ApiURL.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/community_post_detail_controller.dart';

class CommunityPostDetailView extends GetView<CommunityPostDetailController> {
  const CommunityPostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(()=> Text(controller.title.value)),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  // margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  padding: EdgeInsets.only(top: 4, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                    // color: AppColors().app_primary_bg_dark
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24.0,
                          backgroundImage:
                          NetworkImage(controller.postData.value['photo'] ?? ApiURL.placeholder_auth),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(controller.postData.value['fullname'] ?? ""),
                        subtitle: Text(controller.postData.value['created_at'] ?? ""),
                        trailing: Icon(Icons.more_vert_outlined),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                  controller.postData.value['cover']  ?? ApiURL.placeholder_community_cover,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(height: 8),
                            Text(controller.postData.value['title'] ?? "",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            Text(controller.postData.value['description'] ?? ""),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text('${controller.postData.value['post_like'] ?? ''} Upvote'),
                                Text("•", style: TextStyle(fontSize: 20)),
                                Text('${controller.postData.value['post_dislike'] ?? ''} Downvote'),
                                Text("•", style: TextStyle(fontSize: 20)),
                                Text('${controller.postData.value['post_comments'] ?? ''} Comments'),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Text("Comments")
                                      ],
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),

                            SizedBox(height: 8),
                            Text("Comments", style: TextStyle(fontSize: 18)),

                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.postComments.value.length,
                              itemBuilder: (context, index) {
                                dynamic postCommnet = controller.postComments.value[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 24.0,
                                        backgroundImage:
                                        NetworkImage(postCommnet['photo'] ?? ApiURL.placeholder_auth),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      title: Text(postCommnet['fullname'] ?? ""),
                                      subtitle: Text(postCommnet['created_at'] ?? ""),
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    Text(postCommnet['comment']),
                                    SizedBox(height: 16),
                                  ],
                                );
                              },
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 4),
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors().app_primary_dark),
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors().app_natural_white,
                                    ),
                                    child: TextFormField(
                                      controller: controller.commentController,
                                      minLines: 2,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintText: 'Write comments...',
                                          border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () { controller.commentSubmit(); },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors().app_primary_dark),
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors().app_natural_white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Icon(Icons.send_rounded),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}