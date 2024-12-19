import 'package:get/get.dart';

class ScanDetailController extends GetxController {
  //TODO: Implement ScanDetailController
  dynamic data;
  var title = "".obs;

  @override
  void onInit() {
    data = Get.arguments;
    title.value = data['crops'][0];
    print(data);

    super.onInit();
  }
}
