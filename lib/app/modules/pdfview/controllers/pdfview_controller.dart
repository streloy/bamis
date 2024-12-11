import 'package:get/get.dart';

class PdfviewController extends GetxController {
  //TODO: Implement PdfviewController

  var name = "".obs;
  var url = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dynamic decode = Get.arguments;
    print(decode);
    name.value = decode['name'];
    url.value = decode['url'];
  }

}
