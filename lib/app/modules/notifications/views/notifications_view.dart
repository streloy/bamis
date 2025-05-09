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
          title: Text("notification_title".tr),
          titleSpacing: 0,
        ),
        body: Obx(()=> controller.isLoading.value == true ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            dynamic item = controller.notificationList[index];
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item['seen'] == "1" ? AppColors().app_primary_bg_dark : Colors.green
              ),
              child: GestureDetector(
                onTap: () { controller.updateSeen(item); },
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: ClipOval(
                    child: Image.network("https://bamisapp.bdservers.site/assets/auth/profile.jpg", fit: BoxFit.cover),
                  ),
                  title: Text(toBeginningOfSentenceCase("${item['title']}"), maxLines: 2, style: TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(toBeginningOfSentenceCase("${item['body']}"), maxLines: 2,),
                ),
              ),
            );
          },
        ))
    );
  }
}
