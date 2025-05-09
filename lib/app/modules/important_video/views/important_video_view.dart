import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/important_video_controller.dart';

class ImportantVideoView extends GetView<ImportantVideoController> {
  const ImportantVideoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("important_video".tr),
        titleSpacing: 0,
      ),
      body: Container(
        child: Obx(()=>
          controller.videoList.length > 0 ? ListView.builder(
            itemCount: controller.videoList.length,
            itemBuilder: (context, index) {
              dynamic item = controller.videoList[index];
              return GestureDetector(
                onTap: () { print(item); controller.openYoutube(item); },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: AppColors().app_primary_bg_dark,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(item['cover']),
                      ),
                      SizedBox(height: 16),
                      Text(item['title'], style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      Text(item['created_at'])
                    ],
                  ),
                ),
              );
            },
          ) : Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      child: Icon(Icons.emoji_emotions_rounded)
                  ),
                  SizedBox(height: 16),
                  Text("No bulletin found!")
                ]
            ),
          )
        ),
      )
    );
  }
}
