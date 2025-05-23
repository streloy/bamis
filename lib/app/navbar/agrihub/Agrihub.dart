import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/AppColors.dart';
import 'AgrihubController.dart';

class Agrihub extends StatefulWidget {
  const Agrihub({super.key});

  @override
  State<Agrihub> createState() => _AgrihubState();
}

class _AgrihubState extends State<Agrihub> {
  final controller = Get.put(AgrihubController());



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.grass_outlined),
            titleSpacing: 0,
            title: Text("agrihub_title".tr, style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.refresh(value:true),
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    labelColor: AppColors().app_primary,
                    unselectedLabelColor: AppColors().app_primary_dark,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: "agrihub_cultivation".tr),
                      Tab(text: "agrihub_other_technology".tr),
                    ]
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("agrihub_get_cultivation_tips".tr, style: TextStyle(color: AppColors().app_primary, fontSize: 16, fontWeight: FontWeight.w500)),
                            SizedBox(height: 16),

                            Text("agrihub_crop_type".tr, style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors().app_primary, width: 1),
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Obx(()=> DropdownButton(
                                  isExpanded: true,
                                  hint: Text("agrihub_select_crop_type".tr),
                                  value: controller.tabOneCropTypeValue.value.isNotEmpty ? controller.tabOneCropTypeValue.value : null,
                                  onChanged: (dynamic value) {
                                    controller.getCropName(value);
                                  },
                                  items: controller.tabOneCropType.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                    return DropdownMenuItem<String>(
                                      value: value['crop_type'],
                                      child: Text(value['crop_type']),
                                    );
                                  }).toList(),
                                ))
                              ),
                            ),

                            SizedBox(height: 16),
                            Text("agrihub_crop_name".tr, style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors().app_primary, width: 1),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Obx(()=> DropdownButton(
                                  hint: Text("agrihub_select_crop_name".tr),
                                  isExpanded: true,
                                  value: controller.tabOneCropNameValue.value.isNotEmpty ? controller.tabOneCropNameValue.value : [],
                                  onChanged: (dynamic value) {
                                    controller.getCropVariety(value);
                                  },
                                  items: controller.tabOneCropName.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value['crop_name'],
                                      child: Text(value['crop_name']),
                                    );
                                  }).toList(),
                                )),
                              ),
                            ),

                            SizedBox(height: 16),
                            Text("agrihub_crop_variety".tr, style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors().app_primary, width: 1),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Obx(()=> DropdownButton(
                                  hint: Text("agrihub_select_crop_variety".tr),
                                  isExpanded: true,
                                  value: controller.tabOneCropVarietyValue.value.isNotEmpty ? controller.tabOneCropVarietyValue.value : [null],
                                  onChanged: (dynamic value) {
                                    controller.setCropVariety(value);
                                  },
                                  items: controller.tabOneCropVariety.map<DropdownMenuItem<dynamic>>((dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value['crop_variety'],
                                      child: Text(value['crop_variety']),
                                    );
                                  }).toList(),
                                )),
                              ),
                            ),

                            SizedBox(height: 16),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: controller.getTips,
                                  child: Text("agrihub_get_cultivation_tips".tr),
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
                      Center(child: Text("agrihub_other_technology".tr)),
                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
