import 'package:bamis/app/modules/crop_disease_stages/bindings/crop_disease_stages_binding.dart';
import 'package:bamis/app/modules/crop_disease_stages/views/crop_disease_stages_view.dart';
import 'package:bamis/app/modules/mycrop_add/bindings/mycrop_add_binding.dart';
import 'package:bamis/app/modules/mycrop_add/views/mycrop_add_view.dart';
import 'package:bamis/app/modules/crop_adviosry_stages/views/crop_adviosry_stages_view.dart';
import 'package:bamis/app/modules/crop_adviosry_stages/bindings/crop_adviosry_stages_binding.dart';
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
        title: Text('Crop Disease'),
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
                    child: Text("Select particular crop to get specific advisory", style: TextStyle(fontSize: 18, color: AppColors().app_primary)),
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
                child: Obx(()=> Padding(
                  padding: EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: controller.crops.value.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 200, mainAxisSpacing: 16, crossAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      dynamic item = controller.crops.value[index];
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
                ))
            ),
          ],
        )
    );
  }
}
