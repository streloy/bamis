import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ApiURL.dart';

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    // print(fcmToken);
    prefs.setString("FCM", fcmToken.toString());

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // print('PUSH MESSAGE');
      // print(message?.notification?.title);
      // print(message?.notification?.body);
    });

    FirebaseMessaging.onMessage.listen((message) {
      // print('PUSH LISTEN');
      // print(message.notification!.title);
      // print(message.notification!.body);
    });
  }

  Future<void> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Location location = new Location();
    bool _serviceEnabled = await location.serviceEnabled();;
    PermissionStatus _permissionGranted = await location.hasPermission();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    //location.enableBackgroundMode(enable: true);
    var position = await location.getLocation();
    print(position);
    prefs.setString("LAT", position.latitude.toString());
    prefs.setString("LON", position.longitude.toString());

    var response = await http.get(Uri.parse(ApiURL.location_latlon + "?lat=" + position.latitude.toString() + "&lon=" + position.longitude.toString()));
    var decode = jsonDecode(response.body);
    print(decode);
    prefs.setString("LOCATION_ID", decode['result']['id']);
    prefs.setString("LOCATION_NAME", decode['result']['name']);
    prefs.setString("LOCATION_UPAZILA", decode['result']['upazila']);
    prefs.setString("LOCATION_DISTRICT", decode['result']['district']);
  }

}