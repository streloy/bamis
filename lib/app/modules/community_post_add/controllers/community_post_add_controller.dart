import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/ApiURL.dart';
import '../../../../utils/AppColors.dart';

class CommunityPostAddController extends GetxController {
  //TODO: Implement CommunityPostAddController

  var isSelected = false.obs;
  Rx<XFile> file = XFile('./assets/icon.png').obs;
  Rx<File> selectedFile = File('./assets/icon.png').obs;
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postTagController = TextEditingController();
  TextEditingController postDetailController = TextEditingController();

  var token = "";
  var lang = Get.locale?.languageCode;

  @override
  void onInit() {
    super.onInit();
  }

  Future selectImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    file.value = returnImage!;
    selectedFile.value = File(returnImage.path);
    isSelected.value = true;
  }

  Future selectImageFromCamera() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    file.value = returnImage!;
    selectedFile.value = File(returnImage.path);
    isSelected.value = true;
  }

  Future submitCommunityPost() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("TOKEN")!;

    if(postTitleController.text.isEmpty || postTagController.text.isEmpty || postDetailController.text.isEmpty || isSelected == false) {
      Get.snackbar("Warning", "Input field can not be empty!", backgroundColor: AppColors().app_alert_severe, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(bottom: 16, left: 16, right: 16));
      return;
    }

    var url = "${ApiURL.community_postadd}";
    var request = await http.MultipartRequest('POST', Uri.parse(url));
    request.files.add( await http.MultipartFile.fromPath('image', selectedFile.value.path));
    request.fields['title'] = postTitleController.text;
    request.fields['description'] = postDetailController.text;
    request.fields['tag'] = postTagController.text;
    request.headers['Authorization'] = token;
    request.headers['Accept-Language'] = lang.toString();

    var response = await request.send();
    var res = await http.Response.fromStream(response);
    dynamic decode = jsonDecode(res.body);

    print(res.statusCode);
    if(res.statusCode != 200) {
      Get.snackbar("Warning", decode['message'], backgroundColor: AppColors().app_alert_severe, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.only(bottom: 16, left: 16, right: 16));
    } else {
      Get.back();
      Get.snackbar("Success", decode['message'], backgroundColor: AppColors().app_primary, snackPosition: SnackPosition.BOTTOM, colorText: AppColors().app_natural_white, margin: EdgeInsets.only(bottom: 16, left: 16, right: 16));
    }

  }


}
