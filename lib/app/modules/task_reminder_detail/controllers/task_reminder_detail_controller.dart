import 'package:get/get.dart';

class TaskReminderDetailController extends GetxController {
  //TODO: Implement TaskReminderDetailController

  dynamic item = "".obs;
  @override
  void onInit() {
    super.onInit();

    item = Get.arguments;
  }

}
