import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          titleSpacing: 0,
        ),
        body: Obx(()=> ListView.builder(
          itemCount: controller.notificationList.value.length,
          itemBuilder: (context, index) {
            dynamic item = controller.notificationList.value[index];
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item['seen'] == "1" ? AppColors().app_primary_bg_dark : Colors.green
              ),
              child: GestureDetector(
                onTap: () { controller.updateSeen(item); },
                child: ListTile(
                  title: Text(toBeginningOfSentenceCase("${item['title']}"), style: TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(toBeginningOfSentenceCase("${item['body']}")),
                ),
              ),
            );
          },
        ))
    );
  }
}
