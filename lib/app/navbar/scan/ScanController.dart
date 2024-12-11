import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/ApiURL.dart';
import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  File ? selectedFile;
  var selectedImage = "".obs;
  var cropValue = "12".obs;
  var cropList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getLocationList();
  }

  Future getLocationList() async {
    var url = "${ApiURL.bulltin_location}";
    var response = await http.get(Uri.parse(url));
    dynamic decode = jsonDecode(response.body);

    cropList.value = decode['result'];
    cropValue.value = cropList.value[0]['id'];
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