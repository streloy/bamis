import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/crop_adviosry_stage_detail_controller.dart';

class CropAdviosryStageDetailView extends GetView<CropAdviosryStageDetailController> {
  const CropAdviosryStageDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.item['name']),
        titleSpacing: 0,
      ),
      body: Obx(()=> ListView.builder(
        itemCount: controller.stagedetail.value.length,
        itemBuilder: (context, index) {
          dynamic item = controller.stagedetail.value[index];
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                    child: Image.network("${item['image']}", width: double.infinity)
                ),
                SizedBox(height: 16),
                Text("${item['title']}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text("${item['description']}")
              ],
            ),
          );
        },
      )),
    );
  }
}
