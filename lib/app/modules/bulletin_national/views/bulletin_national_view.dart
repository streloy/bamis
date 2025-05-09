import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../../webview/bindings/webview_binding.dart';
import '../../webview/views/webview_view.dart';
import '../controllers/bulletin_national_controller.dart';

class BulletinNationalView extends GetView<BulletinNationalController> {
  const BulletinNationalView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(()=> Text(controller.title.value)),
          titleSpacing: 0,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.white54,
            indicatorWeight: 4,
            indicatorColor: Colors.amber,
            labelColor: Colors.white,
            tabs: [
              Tab(text: "advisory_current".tr),
              Tab(text: "advisory_archive".tr)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(()=>
              controller.bulletinListCurrent.length > 0 ? ListView.builder(
                itemCount:
                controller.bulletinListCurrent.length,
                itemBuilder: (context, index) {
                  dynamic item =
                  controller.bulletinListCurrent[index];
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

            Obx(()=>
              controller.bulletinListArchive.length > 0 ? ListView.builder(
                itemCount:
                controller.bulletinListArchive.length,
                itemBuilder: (context, index) {
                  dynamic item =
                  controller.bulletinListArchive[index];
                  return GestureDetector(
                    onTap: () { Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft ); },
                    child: Container(
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
        )
      ),
    );
  }
}
