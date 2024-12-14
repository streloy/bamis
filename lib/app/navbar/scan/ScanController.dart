import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/ApiURL.dart';
import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  File ? selectedFile;
  var selectedImage = "".obs;
  var cropValue = "".obs;
  var cropList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //getAnalysiscCroplist();
  }

  Future getAnalysiscCroplist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("TOKEN");
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var url = "${ApiURL.analysis_croplist}";
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    print(decode);
    cropList.value = decode['result'];
    cropValue.value = cropList.value[0]['name_short'];
  }

  changeCrop(crop) {
    cropValue.value = crop;
  }

  Future selectImageFromGallery() async{
    // await ImagePicker().pickImage(source: ImageSource.gallery);
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage.value = returnImage!.path;
  }

  Future selectImageFromCamera() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    selectedImage.value = returnImage!.path;
    print(selectedImage.value);
  }



}