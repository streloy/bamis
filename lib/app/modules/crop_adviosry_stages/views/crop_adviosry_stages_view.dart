import 'package:bamis/app/modules/crop_adviosry_stage_detail/bindings/crop_adviosry_stage_detail_binding.dart';
import 'package:bamis/app/modules/crop_adviosry_stage_detail/views/crop_adviosry_stage_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../utils/AppColors.dart';
import '../bindings/crop_adviosry_stages_binding.dart';
import '../controllers/crop_adviosry_stages_controller.dart';

class CropAdviosryStagesView extends GetView<CropAdviosryStagesController> {
  const CropAdviosryStagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mycrop_advisory_stage_title".tr),
        titleSpacing: 0,
      ),
        body: Column(
          children: [

            Container(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Text("mycrop_advisory_stage_promo".tr + " - ${controller.item['crop_name']}", style: TextStyle(fontSize: 18, color: AppColors().app_primary)),
                    flex: 1,
                  ),
                ],
              ),
            ),

            Flexible(
                flex: 1,
                child: Obx(()=> Padding(
                  padding: EdgeInsets.all(16),
                  child: ScrollablePositionedList.builder(
                    itemCount: controller.mycropsstage.value.length,
                    itemBuilder: (context, index) {
                      dynamic item = controller.mycropsstage.value[index];
                      return GestureDetector(
                        onTap: () {
                          if(item['current_status'] != 'upcoming') {
                            Get.to(()=> CropAdviosryStageDetailView(), binding: CropAdviosryStageDetailBinding(), arguments: item, transition: Transition.rightToLeft);
                          } else {
                            Fluttertoast.showToast(msg: "Thsi is stage is started yet. Please wait till this stage will appear.");
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: controller.getStageCardColor(item['current_status'])
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(toBeginningOfSentenceCase("${item['name']}"), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors().app_primary),),
                                  subtitle: Text(toBeginningOfSentenceCase("${item['crop_name']}"), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors().app_primary)),
                                  trailing: Container(
                                    child: Image.network("${item['image']}", height: 64, fit: BoxFit.contain,),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white, width: 6)
                                    ),
                                  ),
                                  horizontalTitleGap: 0,
                                  minVerticalPadding: 0,
                                  minTileHeight: 0,
                                  minLeadingWidth: 0,
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("dashboard_stage_status".tr + ": ${item['current_status']}", style: TextStyle(color: AppColors().app_primary)),
                                    Text("dashboard_plantation".tr + ": ${item['plantationDate']}", style: TextStyle(color: AppColors().app_primary)),
                                    Text("dashboard_stage_duration".tr + ": ${item['stage_start']} - ${item['stage_end']}", style: TextStyle(color: AppColors().app_primary)),
                                  ],
                                )
                              ],
                            )
                        )
                      );
                    },
                  ),
                ))
            ),
          ],
        )
    );
  }
}
