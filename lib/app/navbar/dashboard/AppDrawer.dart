import 'dart:convert';
import 'dart:io';
import 'package:bamis/app/modules/webview/bindings/webview_binding.dart';
import 'package:bamis/app/modules/webview/views/webview_view.dart';
import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../auth/mobile/Mobile.dart';

class AppDrawer extends StatefulWidget {
  // const AppDrawer({super.key});
  final String name, mobile, photo, time;
  AppDrawer({required this.name, required this.mobile, required this.photo, required this.time});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final userPrefService = UserPrefService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors().app_natural_white
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.network(widget.photo, fit: BoxFit.cover),
              ),
            ),
            accountName: Text( widget.name.isEmpty ? widget.mobile : widget.name ),
            accountEmail: Text(widget.time),
            decoration: BoxDecoration(
              color: AppColors().app_primary
            ),
          ),

          ListTile(
            leading: Icon(Icons.video_file_outlined),
            title: Text("dashboard_sidebar_important_video".tr),
            onTap: () { Get.toNamed('important-video'); },
          ),
          GestureDetector(
            onTap: () {
              var item = {
                "title": "dashboard_sidebar_contact_us".tr,
                "url": ApiURL.sidebar_contact_us
              };
              Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft);
            },
            child: ListTile(
              leading: Icon(Icons.support_agent_outlined),
              title: Text("dashboard_sidebar_contact_us".tr),
            ),
          ),
          GestureDetector(
            onTap: () {
              var item = {
                "title": "dashboard_sidebar_faq".tr,
                "url": ApiURL.sidebar_faq
              };
              Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft);
            },
            child: ListTile(
              leading: Icon(Icons.forum_outlined),
              title: Text("dashboard_sidebar_faq".tr),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () async {
              var response = await http.post(ApiURL.fcm, headers: { HttpHeaders.authorizationHeader: '${userPrefService.userToken ?? ''}' } );
              dynamic decode = jsonDecode(response.body) ;

              Get.defaultDialog(
                  title: "Alert",
                  middleText: decode['message'],
                  textCancel: 'OK',
                  onCancel: () async {
                    userPrefService.clearUserData();
                    Get.offAll(Mobile(), transition: Transition.upToDown);
                  }
              );
            },
            child: ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("dashboard_sidebar_logout".tr),
            ),
          )
        ],
      ),
    );
  }
}
