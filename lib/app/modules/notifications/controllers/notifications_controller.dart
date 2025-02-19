import 'dart:convert';

import 'package:bamis/utils/UserPrefService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  var notificationList = [].obs;
  final userPrefService = UserPrefService();
  @override
  void onInit() {
    super.onInit();

    getNotifications();
  }

  Future getNotifications() async {
    var id = userPrefService.userId ?? '';
    var token = userPrefService.userToken ?? '';
    Map<String, String> requestHeaders = {
      'Authorization': token.toString()
    };

    var response = await http.get(Uri.parse(ApiURL.notification_notifications), headers: requestHeaders);
    dynamic decode = jsonDecode(response.body);
    notificationList.value = decode['result'];
    print(notificationList.value);
  }

  Future updateSeen(dynamic item) async {
    var token = userPrefService.userToken ?? '';
    Map<String, String> requestHeaders = {
      'Authorization': token.toString()
    };
    var response = await http.get(Uri.parse(ApiURL.notification_updateseen + "?nid=" + item['id']), headers: requestHeaders);
    getNotifications();
  }

}
