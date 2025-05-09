import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/ApiURL.dart';
import '../../../utils/AppColors.dart';
import '../../auth/mobile/Mobile.dart';
import '../../modules/important_video/bindings/important_video_binding.dart';
import '../../modules/important_video/views/important_video_view.dart';
import '../../modules/webview/bindings/webview_binding.dart';
import '../../modules/webview/views/webview_view.dart';

class AppDrawer extends StatefulWidget {
  // const AppDrawer({super.key});
  final String name, mobile, photo, time;
  AppDrawer({required this.name, required this.mobile, required this.photo, required this.time});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
            onTap: () {
              Get.to(()=> ImportantVideoView(), binding: ImportantVideoBinding(), transition: Transition.rightToLeft);
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support_outlined),
            title: Text("dashboard_sidebar_about_us".tr),
            onTap: () {
              var item = {
                "title": "dashboard_sidebar_about_us".tr,
                "url": ApiURL().getAboutUsUrl()
              };
              Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft);
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text("dashboard_sidebar_contact_us".tr),
            onTap: () {
              var item = {
                "title": "dashboard_sidebar_contact_us".tr,
                "url": ApiURL().getContactUsUrl()
              };
              Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft);
            },
          ),
          ListTile(
            leading: Icon(Icons.forum_outlined),
            title: Text("dashboard_sidebar_faq".tr),
            onTap: () {
              var item = {
                "title": "dashboard_sidebar_faq".tr,
                "url": ApiURL().getFAQUrl()
              };
              Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text("dashboard_sidebar_logout".tr),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var response = await http.post(ApiURL.fcm, headers: { HttpHeaders.authorizationHeader: '${prefs.getString('TOKEN')}' } );
              dynamic decode = jsonDecode(response.body) ;

              Get.defaultDialog(
                  title: "Alert",
                  middleText: decode['message'],
                  textCancel: 'OK',
                  onCancel: () async {
                    await prefs.remove("TOKEN");
                    await prefs.remove("ID");
                    await prefs.remove("NAME");
                    await prefs.remove("EMAIL");
                    await prefs.remove("MOBILE");
                    await prefs.remove("ADDRESS");
                    await prefs.remove("PHOTO");
                    Get.offAll(Mobile(), transition: Transition.upToDown);
                  }
              );
            },
          )
        ],
      ),
    );
  }
}
