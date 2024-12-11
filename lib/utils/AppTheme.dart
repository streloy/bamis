import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const appColor = AppColors();

  AppTheme();

  ThemeData setTheme() {
    return ThemeData(
        scaffoldBackgroundColor: appColor.app_primary_bg_light,
        colorSchemeSeed: appColor.app_natural_white,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: appColor.app_primary,
          foregroundColor: appColor.app_natural_white,
        )
    );
  }
}