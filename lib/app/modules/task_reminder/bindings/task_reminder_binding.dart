import 'package:get/get.dart';

import '../controllers/task_reminder_controller.dart';

class TaskReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskReminderController>(
      () => TaskReminderController(),
    );
  }
}
