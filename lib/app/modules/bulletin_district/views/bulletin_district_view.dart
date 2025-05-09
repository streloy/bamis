import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../../webview/bindings/webview_binding.dart';
import '../../webview/views/webview_view.dart';
import '../controllers/bulletin_district_controller.dart';

class BulletinDistrictView extends GetView<BulletinDistrictController> {
  const BulletinDistrictView({super.key});
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
              tabs: [Tab(text: "advisory_current".tr), Tab(text: "advisory_archive".tr)],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                      child: Text("advisory_select_district".tr, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all()
                    ),
                    child: DropdownButtonHideUnderline(
                        child: Obx(()=> DropdownButton(
                          isExpanded: true,
                          hint: Text("Select Crop Type"),
                          value: controller.bulletinLocationValue.value,
                          onChanged: (dynamic value) {
                            controller.changeLocation(value);
                          },
                          items: controller.bulletinLocation.map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value['id'],
                              child: Text(value['district_name_en']),
                            );
                          }).toList(),
                        ))
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Obx(()=>
                        controller.bulletinListCurrent.length > 0 ? ListView.builder(
                          itemCount: controller.bulletinListCurrent.length,
                          itemBuilder: (context, index) {
                            dynamic item =
                            controller.bulletinListCurrent[index];
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
                                          fontWeight: FontWeight.w700)),
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
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                    child: Text("Select District", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all()
                    ),
                    child: DropdownButtonHideUnderline(
                        child: Obx(()=> DropdownButton(
                          isExpanded: true,
                          hint: Text("Select Crop Type"),
                          value: controller.bulletinLocationValue.value,
                          onChanged: (dynamic value) {
                            controller.changeLocation(value);
                          },
                          items: controller.bulletinLocation.map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value['id'],
                              child: Text(value['district_name_en']),
                            );
                          }).toList(),
                        ))
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Obx(()=>
                      controller.bulletinListArchive.length > 0 ? ListView.builder(
                        itemCount: controller.bulletinListArchive.length,
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
                                        fontWeight: FontWeight.w700)),
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
                    ),
                  ),
                ],
              ),

            ],
          )),
    );
  }
}
