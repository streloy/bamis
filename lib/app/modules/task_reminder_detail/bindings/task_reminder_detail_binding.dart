import 'package:get/get.dart';

import '../controllers/task_reminder_detail_controller.dart';

class TaskReminderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskReminderDetailController>(
      () => TaskReminderDetailController(),
    );
  }
}
