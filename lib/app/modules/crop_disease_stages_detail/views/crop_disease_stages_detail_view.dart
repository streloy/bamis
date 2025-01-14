import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/crop_disease_stages_detail_controller.dart';

class CropDiseaseStagesDetailView
    extends GetView<CropDiseaseStagesDetailController> {
  const CropDiseaseStagesDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.item['name']),
        titleSpacing: 0,
      ),
      body: Obx(()=> ListView(
        children: [
          controller.stagedetail.value.length == 0 ?
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text("Monitor your field!", style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text("No disease alert for your crop.")
              ],
            ),
          ) :
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
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
          )
        ],
      )),
    );
  }
}
