import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../../crop_adviosry_stages/bindings/crop_adviosry_stages_binding.dart';
import '../../crop_adviosry_stages/views/crop_adviosry_stages_view.dart';
import '../controllers/crop_advisory_controller.dart';

class CropAdvisoryView extends GetView<CropAdvisoryController> {
  const CropAdvisoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(result: 'update');
          },
        ),
        title: Text("mycrop_advisory_title".tr),
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
                  child: Text("mycrop_advisory_promo".tr, style: TextStyle(fontSize: 18, color: AppColors().app_primary)),
                  flex: 1,
                ),
                IconButton(
                  onPressed: () { controller.gotoAddCrop(); },
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
                padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
                // child: GridView.builder(
                //   itemCount: controller.crops.value.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 200, mainAxisSpacing: 16, crossAxisSpacing: 16),
                //   itemBuilder: (context, index) {
                //     dynamic item = controller.crops.value[index];
                //     return GestureDetector(
                //       onTap: () { Get.to(()=> CropAdviosryStagesView(), binding: CropAdviosryStagesBinding(), arguments: item, transition: Transition.rightToLeft); },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: AppColors().app_primary_bg_dark
                //         ),
                //         child: Column(
                //           children: [
                //             ClipRRect(
                //               child: Image.network("${item['image']}", height: 140,),
                //             ),
                //             SizedBox(height: 8),
                //             Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("${item['name']}", maxLines: 2))
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
                child: ListView.builder(
                  itemCount: controller.crops.length,
                  itemBuilder: (context, index) {
                    dynamic item = controller.crops[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors().app_primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) { controller.deleteMyCrop(item['id']); },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: "add_mycrop_delete".tr,
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () { Get.to(()=> CropAdviosryStagesView(), binding: CropAdviosryStagesBinding(), arguments: item, transition: Transition.rightToLeft); },
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image.network("${item['image']}"),
                            ),
                            title: Text("${item['name']}", maxLines: 2, style: TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: Text("${item['plantation_date']}", maxLines: 2, style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    );
                  }
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
                      child: Text("You haven't added any crops yet. Please add your crops for getting crop advisory.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20))
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
