import 'package:bamis/app/modules/task_reminder_detail/bindings/task_reminder_detail_binding.dart';
import 'package:bamis/app/modules/task_reminder_detail/views/task_reminder_detail_view.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_reminder_controller.dart';

class TaskReminderView extends GetView<TaskReminderController> {
  const TaskReminderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Reminder'),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Get your task what will help you to manage your farming", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors().app_primary)),
          ),

          Flexible(
            flex: 1,
            child: Obx(()=> controller.tasks.value.length > 0 ?
            ListView.builder(
              itemCount: controller.tasks.value.length,
              itemBuilder: (context, index) {
                dynamic item = controller.tasks.value[index];
                return GestureDetector(
                  onTap: () { Get.to(()=> TaskReminderDetailView(), binding: TaskReminderDetailBinding(), arguments: item, transition: Transition.rightToLeft); },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
                    padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: controller.getCardColor("${item['event_type']}"),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${item['title']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        Text("Crop Name:" +  " ${item['crop_name']}"),
                        Text("Plantation Date:" + " ${item['plantation_date']}"),
                        Text("Event Duration:" + " ${item['event_start_day']} - ${item['event_end_day']}"),
                      ],
                    ),
                  ),
                );
              },
            ) :
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text("Monitor your field!", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Text("No Task for you now.")
                ],
              ),
            )
            ),
          )
        ],
      )
    );
  }
}
