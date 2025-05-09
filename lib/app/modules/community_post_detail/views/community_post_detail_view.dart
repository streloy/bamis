import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../utils/ApiURL.dart';
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
                          NetworkImage(controller.postData['photo'] ?? ApiURL.placeholder_auth),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(controller.postData['fullname'] ?? ""),
                        subtitle: Text(controller.postData['created_at'] ?? ""),
                        trailing: IconButton(onPressed: () { Share.share(controller.postData['url']); }, icon: Icon(Icons.share)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                  controller.postData['cover']  ?? ApiURL.placeholder_community_cover,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(height: 16),
                            Text(controller.postData['title'] ?? "", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            SizedBox(height: 8),
                            Text(controller.postData['description'] ?? ""),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.postData['post_like'].toString() + " Upvote", style: TextStyle(fontSize: 12)),
                                Text(controller.postData['post_dislike'].toString() + " Downvote", style: TextStyle(fontSize: 12)),
                                Text(controller.postData['post_comments'].toString() + " Comments", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(()=> TextButton.icon(
                                  onPressed: () { controller.postReaction('like', controller.postData); },
                                  icon: controller.postData['liked'] == '1' ? Icon(Icons.thumb_up, size: 14) : Icon(Icons.thumb_up_outlined, size: 14),
                                  label: Text("Upvote", style: TextStyle(fontSize: 12)),
                                )),
                                Obx(()=> TextButton.icon(
                                  onPressed: () { controller.postReaction('dislike', controller.postData); },
                                  icon: controller.postData['disliked'] == '1' ? Icon(Icons.thumb_down, size: 14) : Icon(Icons.thumb_down_outlined, size: 14),
                                  label: Text("Downvote", style: TextStyle(fontSize: 12)),
                                )),
                                // TextButton.icon(
                                //   onPressed: () { },
                                //   icon: Icon(Icons.forum_outlined, size: 14),
                                //   label: Text("Comments", style: TextStyle(fontSize: 12)),
                                // ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Text("Comments", style: TextStyle(fontSize: 18)),

                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.postComments.length,
                              itemBuilder: (context, index) {
                                dynamic postCommnet = controller.postComments[index];
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
                                      title: Text(!postCommnet['fullname'].toString().isEmpty ? postCommnet['fullname'] : postCommnet['mobile']),
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
