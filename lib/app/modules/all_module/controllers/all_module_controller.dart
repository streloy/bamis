import 'package:get/get.dart';

class AllModuleController extends GetxController {
  //TODO: Implement AllModuleController

  dynamic dashboardMenu;

  @override
  void onInit() {
    super.onInit();

    dashboardMenu = Get.arguments;
  }


}
