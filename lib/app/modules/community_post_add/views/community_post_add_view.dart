import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/community_post_add_controller.dart';

class CommunityPostAddView extends GetView<CommunityPostAddController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("community_post_add_title".tr),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(()=> Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4)
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  child: controller.isSelected.value != false ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(controller.selectedFile.value!, fit: BoxFit.cover, height: 200, width: double.infinity,),
                  ) :
                  Container( padding: EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: AppColors().app_primary), borderRadius: BorderRadius.circular(4), ) ,child: Center(child: Text("select_photo".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))))
              )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {controller.selectImageFromGallery(); },
                    child: Text("Add Cover Photo"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().app_alert_severe,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 16),
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                    ),
                  )
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: controller.postTitleController,
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Post Title',
                          ),
                        ),
                      ),

                    ],
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: controller.postTagController,
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Post Tag',
                          ),
                        ),
                      ),

                    ],
                  )
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: controller.postDetailController,
                          minLines: 5,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Post Detail',
                          ),
                        ),
                      ),

                    ],
                  )
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {controller.submitCommunityPost(); },
                    child: Text("Add Community Post"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().app_primary,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 16),
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                    ),
                  )
              ),

            ],
          ),
        ),
      )
    );
  }
}
