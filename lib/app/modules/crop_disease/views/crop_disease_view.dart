import 'package:bamis/app/modules/crop_disease_stages/bindings/crop_disease_stages_binding.dart';
import 'package:bamis/app/modules/crop_disease_stages/views/crop_disease_stages_view.dart';
import 'package:bamis/app/modules/mycrop_add/bindings/mycrop_add_binding.dart';
import 'package:bamis/app/modules/mycrop_add/views/mycrop_add_view.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/crop_disease_controller.dart';

class CropDiseaseView extends GetView<CropDiseaseController> {
  const CropDiseaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mycrop_disease_title".tr),
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
                    child: Text("mycrop_disease_promo".tr, style: TextStyle(fontSize: 18, color: AppColors().app_primary)),
                    flex: 1,
                  ),
                  IconButton(
                      onPressed: () { Get.to(()=> MycropAddView(), binding: MycropAddBinding(), transition: Transition.rightToLeft); },
                      icon: Icon(Icons.add),
                      style: IconButton.styleFrom(backgroundColor: AppColors().app_primary_bg_dark)
                  )
                ],
              ),
            ),

            Flexible(
                flex: 1,
                child: Obx(()=>
                  controller.crops.length > 0 ?
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      itemCount: controller.crops.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 200, mainAxisSpacing: 16, crossAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        dynamic item = controller.crops[index];
                        return GestureDetector(
                          onTap: () { Get.to(()=> CropDiseaseStagesView(), binding: CropDiseaseStagesBinding(), arguments: item, transition: Transition.rightToLeft); },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors().app_primary_bg_dark
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.network("${item['image']}", height: 140,),
                                ),
                                SizedBox(height: 8),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("${item['name']}", maxLines: 2))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors().app_primary_bg_dark
                        ),
                        child: Text("You haven't added any crops yet. Please add your crops for getting disease alert.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20))
                      )
                    ],
                  )
                )
            ),
          ],
        )
    );
  }
}
