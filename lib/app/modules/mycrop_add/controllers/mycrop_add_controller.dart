import 'dart:convert';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/ApiURL.dart';

class MycropAddController extends GetxController {

  final userPrefService = UserPrefService();
  var crops = [].obs;
  var cropsValue = "".obs;
  var locations = [].obs;
  var locationsValue = "".obs;
  DateTime selectedDate = DateTime.now();
  var plantationDateValue = "".obs;
  TextEditingController locationController = TextEditingController();
  TextEditingController plantationDateController = TextEditingController();

  String displayStringForOption(dynamic option) => option.location;

  @override
  void onInit() {
    super.onInit();
    getMasterInfo();
  }

  Future getMasterInfo() async {
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.get(Uri.parse("${ApiURL.mycrops_croplist}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    crops.value = decode['result'];
    cropsValue.value = crops.value[0]['value'];

    var response_location = await http.get(Uri.parse("${ApiURL.mycrops_locations}"), headers: requestHeaders);
    dynamic decode_location = jsonDecode(response_location.body);
    if(response_location.statusCode != 200) {
      Fluttertoast.showToast(msg: decode_location['message'], toastLength: Toast.LENGTH_LONG);
    }
    locations.value = decode_location['result'];
    locationsValue.value = locations.value[0]['id'];
  }

  Future openCalender(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      plantationDateController.text = selectedDate.toString().substring(0,10);
    }
  }
  
  
  Future addYourCrop() async {
    if (cropsValue.value.isEmpty || locationsValue.value.isEmpty || plantationDateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Input field can not be empty!");
    }

    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var params = jsonEncode({
      "crop_name": "${cropsValue.value}",
      "plantation_date": "${plantationDateController.text}",
      "location_id": locationsValue.value
    });

    var response = await http.post(Uri.parse("${ApiURL.mycrops_crops}"), body: params, headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    print(decode);
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
      Get.back(result: 'update');
    }
  }

}
