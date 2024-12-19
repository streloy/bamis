import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../scan_detail/bindings/scan_detail_binding.dart';
import '../../scan_detail/views/scan_detail_view.dart';
import '../controllers/pest_disease_alerts_controller.dart';

class PestDiseaseAlertsView extends GetView<PestDiseaseAlertsController> {
  const PestDiseaseAlertsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.pest_control),
        title: Text("title".tr),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 16),
            child: Obx(()=> DropdownButtonFormField(
              value: controller.cropValue.value,
              onChanged: (dynamic? value) {
                controller.cropValue.value = value;
                controller.changeCrop(value);
              },
              items: controller.cropList.value.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value['value'],
                  child: Text(value['name']),
                );
              }).toList(),
              decoration: InputDecoration(
                  labelText: "select_crop".tr,
                  border: OutlineInputBorder()
              ),
            ),)
          ),

          Expanded(
            child: Obx(()=> ListView.builder(
              itemCount: controller.diseaseList.value.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                dynamic disease = controller.diseaseList.value[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text("${disease['stage']}", style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary)),
                      trailing: TextButton(onPressed: () { print(disease); }, child: Text("See all")),
                    ),
                    Container(
                      height: 230,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: disease['data'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contextOne, indexOne) {
                          dynamic diseaseItem = disease['data'][indexOne];
                          return InkWell(
                            onTap: () { controller.openDetailPage(diseaseItem); },
                            child: Container(
                              width: 200,
                              margin: EdgeInsets.only(right: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors().app_primary_bg_dark
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(diseaseItem['default_image'], width: 180, height: 140, fit: BoxFit.cover,)),
                                  SizedBox(height: 8),
                                  Text(diseaseItem['name'], maxLines: 2)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),)
          ),
        ],
      )
    );
  }
}
