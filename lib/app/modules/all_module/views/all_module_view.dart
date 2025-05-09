import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/all_module_controller.dart';

class AllModuleView extends GetView<AllModuleController> {
  const AllModuleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("all_application".tr),
        titleSpacing: 0,
      ),
      body: ListView.builder(
        itemCount: controller.dashboardMenu.length,
        itemBuilder: (context, index) {
          dynamic item = controller.dashboardMenu[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(controller.dashboardMenu[index]['page']);
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .1, color: AppColors().app_primary)
                ),
                child: ListTile(
                  horizontalTitleGap: 16,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors().app_primary_bg_dark,
                    ),
                    child: Image.asset('assets/module_icons/${item['image']}')
                  ),
                  title: Text("${item['name']}".tr),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
