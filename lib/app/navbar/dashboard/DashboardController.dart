import 'dart:convert';

import 'package:bamis/utils/ApiURL.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {

  final List<dynamic> dashboardMenu = [
    {
      "name": "dashboard_weather_forecast",
      "image": "weather_forecast.png",
      "page": "weather-forecast"
    },
    {
      "name": "dashboard_weather_alert",
      "image": "weather_alert.png",
      "page": "weather-alert"
    },
    {
      "name": "dashboard_flood_forecast",
      "image": "flood_forecast.png",
      "page": "flood-forecast"
    },
    {
      "name": "dashboard_crop_advisory",
      "image": "crop_advisory.png",
      "page": "crop-advisory"
    },
    {
      "name": "dashboard_pest_disease",
      "image": "pest_disease_alert.png",
      "page": "pest-disease-alerts"
    },
    {
      "name": "dashboard_task_reminder",
      "image": "task_reminder.png",
      "page": "task-reminder"
    },
    {
      "name": "dashboard_advisory_bulletin",
      "image": "advisory_bulletin.png",
      "page": "bulletins"
    },
    {
      "name": "dashboard_online_library",
      "image": "online_library.png",
      "page": "elibrary"
    },
    {
      "name": "dashboard_farm_metrics",
      "image": "farm_metrics.png",
      "page": "farm-metrics"
    }
  ];

  var initTime = "Good Morning".obs;
  late var fullname = "".obs;
  late var photo = "".obs;

  //weather
  var currentLocationId = "".obs;
  var currentLocationName = "".obs;
  dynamic forecast = [].obs;
  var cLocationUpazila = "".obs;
  var cLocationDistrict = "".obs;

  @override
  void onInit() {
    getTime();
    getSharedPrefData();
  }

  getTime() {
    var currentHour = DateTime.timestamp();
    var hour = int.parse(currentHour.toString().substring(11, 13)) + 6;
    if(hour > 23) {
      hour = hour - 23;
    }
    if (hour >= 5 && hour < 12) {
      initTime.value = "Good Morning";
    } else if (hour >= 12 && hour < 15) {
      initTime.value = "Good Noon";
    } else if (hour >= 15 && hour < 17) {
      initTime.value = "Good Afternoon";
    } else if (hour >= 17 && hour < 19) {
      initTime.value = "Good Evening";
    } else {
      initTime.value = "Good Night";
    }
  }

  Future getSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullname.value = (await prefs.getString("NAME"))!;
    currentLocationId.value = await prefs.getString("LOCATION_ID")!;
    currentLocationName.value = await prefs.getString("LOCATION_NAME")!;
    cLocationUpazila.value = await prefs.getString("LOCATION_UPAZILA")!;
    cLocationDistrict.value = await prefs.getString("LOCATION_DISTRICT")!;
    photo.value = ApiURL.base_url_image + (await prefs.getString("PHOTO"))!;

    getForecast(currentLocationId.value);
  }


  Future getForecast(locationId) async {
    var response = await http.get(Uri.parse(ApiURL.currentforecast + "?location=$locationId"));
    dynamic decode = jsonDecode(response.body);
    forecast.value = decode['result'];
  }

  gotoNotificationPage() {
    Get.toNamed('notifications');
  }

}