import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget {
  // const AppDrawer({super.key});
  final String name, photo, time;
  AppDrawer({required this.name, required this.photo, required this.time});

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
            accountName: Text(widget.name),
            accountEmail: Text(widget.time),
            decoration: BoxDecoration(
              color: AppColors().app_primary
            ),
          ),
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text("Save Articles"),
            onTap: () { print("Save Articles"); },
          ),
          ListTile(
            leading: Icon(Icons.video_file_outlined),
            title: Text("Important Videos"),
            onTap: () { Get.toNamed('important-video'); },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text("Contact Us"),
          ),
          ListTile(
            leading: Icon(Icons.forum_outlined),
            title: Text("FAQ"),
          ),
          ListTile(
            leading: Icon(Icons.photo_outlined),
            title: Text("Photo Gallery"),
          )
        ],
      ),
    );
  }
}
