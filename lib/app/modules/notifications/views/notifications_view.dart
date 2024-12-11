import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: ListView.builder(
        itemCount: 100,

        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors().app_primary_bg_dark
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text("Notification Title ${index + 1}", style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text("You got the notification because your location is in danger region or it is very close to you "),
            ),
          );
        },
      )
    );
  }
}
