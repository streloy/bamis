import 'package:bamis/app/modules/community_post_detail/bindings/community_post_detail_binding.dart';
import 'package:bamis/app/modules/community_post_detail/views/community_post_detail_view.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/community_post_my_controller.dart';

class CommunityPostMyView extends GetView<CommunityPostMyController> {
  const CommunityPostMyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Community Post'),
        titleSpacing: 0,
      ),
      body: Obx(()=> ListView.builder(
        itemCount: controller.post.value.length,
        itemBuilder: (context, index) {
          dynamic item = controller.post.value[index];
          return GestureDetector(
            onTap: () { Get.to(()=> CommunityPostDetailView(), binding: CommunityPostDetailBinding(), arguments: item, transition: Transition.rightToLeft); },
            child: Container(
              margin: EdgeInsets.only(left: 16, top: 16, right: 16),
              decoration: BoxDecoration(
                  color: AppColors().app_primary_bg_dark
              ),
              child: ListTile(
                leading: Image.network("${item['cover']}", width: 60, height: 60, fit: BoxFit.cover,),
                title: Text(item['title']),
                subtitle: Text(item['created_at']),
                horizontalTitleGap: 16,
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          );
        },
      ))
    );
  }
}
