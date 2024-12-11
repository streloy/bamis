import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import '../controllers/elibrary_controller.dart';

class ElibraryView extends GetView<ElibraryController> {
  const ElibraryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('elibrary_title'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Get necessary books and articles that help your farming",
                      maxLines: 2,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Ink(
                    decoration: ShapeDecoration(
                      color: AppColors().button_bg,
                      shape: CircleBorder()
                    ),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.search),
                      color: AppColors().app_primary,
                    ),
                  )
                ],
              ),

              SizedBox(height: 16),

              Container(
                height: 50,
                child: Obx(()=> ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.tags.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors().button_bg,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(controller.tags[index], style: TextStyle(fontSize: 20, color: AppColors().app_primary),),
                    );
                  },
                ),),
              ),

              SizedBox(height: 16),

              Obx(()=> GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 300, mainAxisSpacing: 16, crossAxisSpacing: 16),
                itemCount: controller.books.length,

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Saim SAIM SAIM");
                      controller.loadPDF(controller.books[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                        // color: AppColors().button_bg,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network("${controller.books[index]['cover']}", height: 220, width: double.infinity, fit: BoxFit.cover,),
                            ),
                          ),
                          Padding( padding: EdgeInsets.symmetric(horizontal: 12) ,child: Text("${controller.books[index]['name']}", overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: 16, color: AppColors().app_primary)))
                        ],
                      ),
                    ),
                  );
                },
              ),)
            ],
          ),
        ),
      )
    );
  }
}
