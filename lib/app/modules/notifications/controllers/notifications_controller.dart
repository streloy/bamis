import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  var notificationList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    getNotifications();
  }

  Future getNotifications() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("ID");
    var token = prefs.getString("TOKEN");
    Map<String, String> requestHeaders = {
      'Authorization': token.toString()
    };

    var response = await http.get(Uri.parse(ApiURL.notification_notifications), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    notificationList.value = decode['result'];
    isLoading.value = false;
  }

  Future updateSeen(dynamic item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("TOKEN");
    Map<String, String> requestHeaders = {
      'Authorization': token.toString()
    };
    var response = await http.get(Uri.parse(ApiURL.notification_updateseen + "?nid=" + item['id']), headers: requestHeaders);
    getNotifications();
  }

}
