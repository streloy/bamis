import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_reminder_detail_controller.dart';

class TaskReminderDetailView extends GetView<TaskReminderDetailController> {
  const TaskReminderDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.item['title']}') ,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network("${controller.item['image']}", width: double.infinity)
              ),
              SizedBox(height: 16),
              Text("${controller.item['title']}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Text("${controller.item['description']}"),
              controller.item['event_type'] == 'procedure' ? 
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.item['procedures'].length,
                    itemBuilder: (context, index) {
                      dynamic item = controller.item['procedures'][index];
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network("${item['image']}", width: double.infinity)
                            ),
                            SizedBox(height: 16),
                            Text("${item['caption']}"),
                            SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ) :
                  SizedBox(height: 0)
            ],
          ),
        ),
      )
    );
  }
}
