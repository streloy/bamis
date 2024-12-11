import 'dart:io';

import 'package:bamis/app/navbar/scan/ScanController.dart';
import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final controller = Get.put(ScanController());

  File ? selectedFile;
  Future selectImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedFile = File(returnImage!.path);
    });
  }

  Future selectImageFromCamera() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedFile = File(returnImage!.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.pest_control),
        title: Text("Pest & Disease Detection"),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: DropdownButtonFormField(
                value: controller.cropValue.value,
                onChanged: (dynamic? value) {
                  controller.changeCrop(value);
                },
                items: controller.cropList.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value['id'],
                    child: Text(value['district_name_en']),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Select Crop",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
                ),
                margin: EdgeInsets.symmetric(vertical: 16),
                child: selectedFile != null ?
                  ClipRRect( borderRadius: BorderRadius.circular(16), child: Image.file(selectedFile!, fit: BoxFit.cover)) :
                  Container( padding: EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: AppColors().app_primary), borderRadius: BorderRadius.circular(16), ) ,child: Center(child: Text("No photo selected, Please select or capture one phone!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))))
              ),
            ),
            
            selectedFile != null ?
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors().app_primary
              ),
              child: TextButton(
                  onPressed: () {},
                  child: Text("Detect Pest or Disease", style: TextStyle(color: AppColors().app_natural_white))
              ),
            ) : SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () { selectImageFromGallery(); },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors().app_primary_bg_dark
                    ),
                    child: Icon(Icons.image_outlined, size: 30, color: AppColors().app_primary),
                  ),
                ),
                GestureDetector(
                  onTap: () { selectImageFromCamera(); },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors().app_primary
                    ),
                    child: Icon(Icons.camera_outlined, size: 30, color: AppColors().app_primary_bg_dark),
                  ),
                ),

                selectedFile == null ?
                GestureDetector(
                  onTap: () { },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors().app_primary_bg_dark
                    ),
                    child: Icon(Icons.info_outline, size: 30, color: AppColors().app_primary),
                  ),
                ) :
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFile = null;
                    });
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors().app_primary_bg_dark
                    ),
                    child: Icon(Icons.close, size: 30, color: AppColors().app_primary),
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
