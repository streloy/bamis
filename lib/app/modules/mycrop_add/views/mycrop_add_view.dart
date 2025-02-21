import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/AppColors.dart';
import '../controllers/mycrop_add_controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MycropAddView extends GetView<MycropAddController> {

  const MycropAddView({super.key});

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
        title: Text('add_mycrop_title'.tr),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                child: Obx(()=> DropdownButtonFormField(
                  value: controller.cropsValue.value,
                  onChanged: (dynamic value) {
                    controller.cropsValue.value = value;
                  },
                  items: controller.crops.value.map<DropdownMenuItem<dynamic>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['value'],
                      child: Text(value['name']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                      labelText: "add_mycrop_select_crop".tr,
                      border: OutlineInputBorder()
                  ),
                ),)
            ),

            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
              child: TypeAheadField<dynamic>(
                suggestionsCallback: (search) => controller.locations.value.where((location) => location['location'].toLowerCase().contains(search.toLowerCase())).toList(),
                builder: (context, controller, focusNode) {
                  return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'add_mycrop_select_location'.tr,
                      )
                  );
                },
                controller: controller.locationController,
                itemBuilder: (context, location) {
                  return ListTile( title: Text(location['location']), subtitle: Text(location['district']), );
                },
                onSelected: (location) {
                  controller.locationController.text = location['location'];
                  controller.locationsValue.value = location['id'];
                },
              ),
            ),

            Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: controller.plantationDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'add_mycrop_select_plantation_date'.tr,
                          suffixIcon: IconButton(onPressed: () { controller.openCalender(context); }, icon: Icon(Icons.calendar_month)),
                        ),
                      ),
                    ),

                  ],
                )
            ),

            Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: controller.addYourCrop,
                  child: Text("add_mycrop_submit".tr),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().app_primary,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16),
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                  ),
                )
            ),

          ]
        ),
      ),
    );
  }
}
