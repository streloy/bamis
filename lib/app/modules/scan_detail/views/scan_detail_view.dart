import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import '../controllers/scan_detail_controller.dart';

class ScanDetailView extends GetView<ScanDetailController> {
  const ScanDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
        titleSpacing: 0,
      ),
      body: ListView.builder(
        itemCount: controller.data['predicted_diagnoses'].length,
        itemBuilder: (context, index) {
          dynamic item = controller.data['predicted_diagnoses'][index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: item['image_references'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index2) {
                    dynamic item2 = item['image_references'][index2];
                    return Container(
                      padding: EdgeInsets.only(right: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: InstaImageViewer(
                            child: Image(
                                image: Image.network(item2).image
                            )
                        )
                      )
                    );
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("disease_name".tr)
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("${item['common_name']}".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors().app_primary))
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("scientific_name".tr)
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("${item['scientific_name']}".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors().app_primary))
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("pathogen".tr)
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("${item['pathogen_class']}".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors().app_primary))
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("can_also_found".tr)
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                child: ListView.builder(
                  itemCount: item['hosts'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, hostIndex) {
                    dynamic hostItem = item['hosts'][hostIndex];
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors().app_primary_bg_dark
                      ),
                      child: Text("${hostItem}".tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors().app_primary))
                    );
                  },
                ),
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("preventive_measures".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("• " + item['preventive_measures'].join("\n• "))
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("symptoms".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(item['symptoms'])
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("symptoms_short".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("• " + item['symptoms_short'].join("\n• "))
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("treatment_chemical".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(item['treatment_chemical'])
              ),

              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("treatment_organic".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(item['treatment_organic'])
              ),


              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("trigger".tr, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors().app_primary, fontSize: 16),)
              ),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(item['trigger'])
              ),

              SizedBox(height: 32)


            ],
          );
        },
      )
    );
  }
}
