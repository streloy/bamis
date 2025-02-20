import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/UserPrefService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DashboardController extends GetxController {

  final userPrefService = UserPrefService();
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
      "page": "crop-disease"
    },
    {
      "name": "dashboard_pest_disease_information",
      "image": "pest_disease_information.png",
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
    // {
    //   "name": "dashboard_farm_metrics",
    //   "image": "farm_metrics.png",
    //   "page": "farm-metrics"
    // }
  ];

  var initTime = "Good Morning".obs;
  late var fullname = "".obs;
  late var mobile = "".obs;
  late var photo = "".obs;

  //weather
  var currentLocationId = "".obs;
  var currentLocationName = "".obs;
  dynamic forecast = [].obs;
  dynamic notification = [].obs;
  dynamic mycrops = [].obs;
  dynamic mycropsstage = [].obs;
  dynamic bulletins = [].obs;
  var notificationValue = "".obs;
  var cLocationUpazila = "".obs;
  var cLocationDistrict = "".obs;
  var isForecastLoading = false.obs;

  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void onInit() {
    getTime();
    getSharedPrefData();
  }

  Future onRefresh() async {
    await getTime();
    await getSharedPrefData();
  }

  Future openModule(index) async {
    var result = Get.toNamed(dashboardMenu[index]['page']);
    if(result == 'update') {
      Get.snackbar("Back Button", "Back button pressed", snackPosition: SnackPosition.BOTTOM, padding: EdgeInsets.only(bottom: 16)).show();
    }
  }

  getTime() {
    var currentHour = DateTime.timestamp();
    var hour = int.parse(currentHour.toString().substring(11, 13)) + 6;
    if(hour > 23) {
      hour = hour - 23;
    }
    if (hour >= 5 && hour < 12) {
      initTime.value = "dashboard_time_good_morning".tr;
    } else if (hour >= 12 && hour < 15) {
      initTime.value = "dashboard_time_good_noon".tr;
    } else if (hour >= 15 && hour < 17) {
      initTime.value = "dashboard_time_good_afternoon".tr;
    } else if (hour >= 17 && hour < 19) {
      initTime.value = "dashboard_time_good_evening".tr;
    } else {
      initTime.value = "dashboard_time_good_night".tr;
    }
  }

  Future getSharedPrefData() async {
    fullname.value = userPrefService.userName ?? "";
    mobile.value = userPrefService.userMobile ?? "";
    currentLocationId.value = userPrefService.locationId ?? '';
    currentLocationName.value = userPrefService.locationName ?? '';
    cLocationUpazila.value = userPrefService.locationUpazila ?? '';
    cLocationDistrict.value = userPrefService.locationDistrict ?? '';
    photo.value = ApiURL.base_url_image + (userPrefService.userPhoto ?? '');

    getForecast(currentLocationId.value);
    getNotifications();
    getMyCrops();
    getBulletins();
  }

  Future getNotifications() async {
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };

    var response = await http.get(Uri.parse(ApiURL.notification_notifications), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body) ?? [];
    notification.value = decode['result'] ?? [];
    var seen = 0;
    notification.value.forEach((item){
      item['seen'] == "1" ? seen++ : seen = seen;
    });
    notificationValue.value = "${notification.value.length - seen}";
  }

  Future getMyCrops() async {
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse(ApiURL.mycrops_crops), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body) ?? [];
    mycrops.value = decode['result'] ?? [];
    if(mycrops.value.length > 0) {
      getMyCropStage(mycrops.value[0]);
    }
  }

  Future getMyCropStage(dynamic item) async {
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse("${ApiURL.mycrops_mycropstage}?id=${item['id']}"), headers: requestHeaders);
    dynamic decode = await jsonDecode(response.body.toString());
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    mycropsstage.value = decode['result'];
  }

  Future getBulletins() async {
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse("${ApiURL.bulltin_dashboard}"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body.toString());
    if(response.statusCode != 200) {
      Fluttertoast.showToast(msg: decode['message'], toastLength: Toast.LENGTH_LONG);
    }
    bulletins.value = decode['result'];
  }

  Future getForecast(locationId) async {
    isForecastLoading.value = true;
    var token = userPrefService.userToken ?? '';
    var lang = Get.locale?.languageCode;

    Map<String, String> requestHeaders = {
      'Authorization': token.toString(),
      'Accept-Language': lang.toString()
    };
    var response = await http.get(Uri.parse(ApiURL.currentforecast + "?location=$locationId"), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    forecast.value = decode['result'];
    isForecastLoading.value = false;
  }

  Future gotoNotificationPage() async{
    await Get.toNamed('notifications');
  }

  Color getStageCardColor(String item) {
    if(item == 'completed') {
      return Color(0xFFE1FFDF);
    } else if(item == 'ongoing') {
      return Color(0xFFFFF3BB);
    } else if(item == 'upcoming') {
      return Color(0xFFB2B2B2);
    } else {
      return Color(0xFFB2B2B2);
    }
  }

}