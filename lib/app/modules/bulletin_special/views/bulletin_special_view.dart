import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/bulletin_special_controller.dart';

class BulletinSpecialView extends GetView<BulletinSpecialController> {
  const BulletinSpecialView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(controller.title.value)),
            titleSpacing: 0,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.white54,
              indicatorWeight: 4,
              indicatorColor: Colors.amber,
              labelColor: Colors.white,
              tabs: [Tab(text: "Current"), Tab(text: "Archive")],
            ),
          ),
          body: TabBarView(
            children: [
              Obx(()=>
                  controller.bulletinListCurrent.value.length > 0 ? ListView.builder(
                    itemCount:
                    controller.bulletinListCurrent.value.length,
                    itemBuilder: (context, index) {
                      dynamic item =
                      controller.bulletinListCurrent.value[index];
                      return Container(
                        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                        decoration: BoxDecoration(
                            color: AppColors().app_primary_bg_dark,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: ListTile(
                          leading: Icon(Icons.file_present, size: 36),
                          title: Text("${item['title_bn']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          subtitle: Text("${item['publish_date']}"),
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

              Obx(()=>
                controller.bulletinListArchive.value.length > 0 ? ListView.builder(
                  itemCount:
                  controller.bulletinListArchive.value.length,
                  itemBuilder: (context, index) {
                    dynamic item =
                    controller.bulletinListArchive.value[index];
                    return Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      decoration: BoxDecoration(
                          color: AppColors().app_primary_bg_dark,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListTile(
                        leading: Icon(Icons.file_present, size: 36),
                        title: Text("${item['title_bn']}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        subtitle: Text("${item['publish_date']}"),
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

            ],
          )),
    );
  }
}
