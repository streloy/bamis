import 'package:bamisportal/utils/AppTheme.dart';
import 'package:bamisportal/utils/FirebaseService.dart';
import 'package:bamisportal/utils/LocalizationString.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'dart:io' show Platform;

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseService().initNotifications();
  }
  await Firebase.initializeApp();
  await FirebaseService().getLocation();

  runApp(
    GetMaterialApp(
      title: 'title'.tr,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: new AppTheme().setTheme(),
      translations: LocalizationString(),
      locale: Locale('bn', 'BD'),
    ),
  );
}
