import 'package:bamis/firebase_options.dart';
import 'package:bamis/utils/AppTheme.dart';
import 'package:bamis/utils/FirebaseService.dart';
import 'package:bamis/utils/LocalizationString.dart';
import 'package:bamis/utils/NotifiationService.dart';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase Initialization for Android, iOS, and Web
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    // User Preferences Initialization
    await UserPrefService().init();

    // Firebase Notification Initialization (Only for Android)
    if (Platform.isAndroid) {
      await FirebaseService().initNotifications();
    }

    // Location fetching
    await FirebaseService().getLocation();

  } catch (e, stack) {
    print('🔥 Firebase Initialization Error: $e');
    print(stack);
  }

  runApp(
    GetMaterialApp(
      title: 'title'.tr,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().setTheme(),
      translations: LocalizationString(),
      locale: const Locale('bn', 'BD'),
    ),
  );
}