import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_reminder_controller.dart';

class TaskReminderView extends GetView<TaskReminderController> {
  const TaskReminderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskReminderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TaskReminderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
