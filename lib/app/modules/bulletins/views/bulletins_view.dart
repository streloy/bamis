import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/bulletins_controller.dart';

class BulletinsView extends GetView<BulletinsController> {
  const BulletinsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('advisory_title'.tr),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text("advisory_promo".tr,
              maxLines: 3,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors().app_primary),
            ),
          ),
          Expanded(
            child: Obx(()=> ListView.builder(
              itemCount: controller.bulletinCategory.length,
              itemBuilder: (context, index) {
                dynamic item = controller.bulletinCategory[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.book_rounded, size: 48),
                      title: Text(item['name_bn'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      subtitle: Text("সর্বশেষ ${item['name_bn']}"),
                      trailing: Icon(Icons.arrow_forward_outlined),
                      onTap: () { controller.openBulletinList(item); },
                    ),
                    Divider()
                  ],
                );
              },
            ),)
          )
        ],
      ),
    );
  }
}
