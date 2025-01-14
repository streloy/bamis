import 'package:bamis/firebase_options.dart';
import 'package:bamis/utils/AppTheme.dart';
import 'package:bamis/utils/FirebaseService.dart';
import 'package:bamis/utils/LocalizationString.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initNotifications();
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
