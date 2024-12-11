import 'package:bamis/app/navbar/scan/Scan.dart';
import 'package:bamis/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF015205),
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(Scan());
          //controller.onItemTapped(4);
        },
        tooltip: "Scan",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        surfaceTintColor: Colors.white,
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavbarItem(Icons.home, "tab_home", 0),
            buildNavbarItem(Icons.grass_outlined, "tab_agri", 1),
            const SizedBox(width: 20),
            buildNavbarItem(Icons.forum_rounded, "tab_community", 2),
            buildNavbarItem(Icons.person, "tab_profile", 3),
          ],
        ),
      ),
      body: Obx(()=> controller.screen.elementAt(controller.currentTab.value))
    );
  }


  Widget buildNavbarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => {controller.changePage(index)},
      splashFactory: NoSplash.splashFactory,
      child: Column(
        children: [
          Obx(()=> Icon( icon, color: controller.currentTab == index ? const Color(0xFF015205) : Colors.black54) ),
          Obx(()=> Text( label.tr, style: TextStyle( color:  controller.currentTab == index ? const Color(0xFF015205) : Colors.black54 ) ))
        ],
      ),
    );
  }
}
