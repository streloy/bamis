import 'dart:convert';
import 'dart:io';

import 'package:bamis/app/modules/scan_detail/bindings/scan_detail_binding.dart';
import 'package:bamis/app/modules/scan_detail/views/scan_detail_view.dart';
import 'package:bamis/app/navbar/scan/ScanController.dart';
import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final controller = Get.put(ScanController());

  var file;
  File ? selectedFile;
  var cropList = [];
  var cropValue = "";
  var token = "";
  var lang = Get.locale?.languageCode;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    getAnalysiscCroplist();
  }

  Future selectImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = returnImage;
      selectedFile = File(returnImage!.path);
    });
  }

  Future selectImageFromCamera() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = returnImage;
      selectedFile = File(returnImage!.path);
    });
  }

  Future getAnalysiscCroplist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("TOKEN")!;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = "${ApiURL.analysis_croplist}";
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);

    setState(() {
      cropList = decode['result'];
      cropValue = cropList[0]['name_short'];
    });
  }

  Future detectImageAndPest() async {
    setState(() { isLoading = true; });
    var url = "${ApiURL.analysis_image}";
    var request = await http.MultipartRequest('POST', Uri.parse(url));
    request.files.add( await http.MultipartFile.fromPath('image', selectedFile!.path));
    request.fields['crop'] = cropValue;
    request.headers['Authorization'] = token.toString();
    request.headers['Accept-Language'] = lang.toString();

    var response = await request.send();
    var res = await http.Response.fromStream(response);
    dynamic decode = jsonDecode(res.body);
    setState(() { isLoading = false; });
    if(res.statusCode != 200) {
      showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text("scan_warning".tr),
            content: Text(decode['message']),
            actions: <Widget>[ TextButton( child: Text("scan_ok".tr), onPressed: () { Navigator.of(context).pop(); }, ), ],
          )
      );
    } else {
      Get.to(()=> ScanDetailView(), binding: ScanDetailBinding(), arguments: decode, transition: Transition.rightToLeft);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.pest_control),
        title: Text("scan_title".tr),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: DropdownButtonFormField(
                value: cropValue,
                onChanged: (dynamic value) {
                  setState(() {
                    cropValue = value;
                  });
                },
                items: cropList.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value['name_short'],
                    child: Text(value['name']),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "select_crop".tr,
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.expand,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: selectedFile != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(selectedFile!, fit: BoxFit.cover),
                      ) :
                      Container( padding: EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: AppColors().app_primary), borderRadius: BorderRadius.circular(16), ) ,child: Center(child: Text("select_photo".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))))
                  ),

                  isLoading != false ?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 8),
                        Text("wait".tr, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700))
                      ],
                    ),
                  ) : SizedBox(height: 0)
                ],
              )
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
                  onPressed: () { detectImageAndPest(); },
                  child: Text("detect_disease_pest".tr, style: TextStyle(color: AppColors().app_natural_white))
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
