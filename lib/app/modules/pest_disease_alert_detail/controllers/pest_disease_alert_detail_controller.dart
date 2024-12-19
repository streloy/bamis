import 'package:get/get.dart';

class PestDiseaseAlertDetailController extends GetxController {
  //TODO: Implement PestDiseaseAlertDetailController
  var name = "".obs;
  dynamic data;

  @override
  void onInit() {
    dynamic decode = Get.arguments;
    data = decode;
    name.value = decode['name'];
    super.onInit();
  }

}
