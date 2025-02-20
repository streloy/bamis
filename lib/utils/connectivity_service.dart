import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkController extends GetxController {
  var isNetworkWorking = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkNetworkStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateStatus(result);
    });
  }

  Future<void> checkNetworkStatus() async {
    final result = await Connectivity().checkConnectivity();
    _updateStatus(result);
  }

  Future<void> _updateStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      isNetworkWorking.value = true;
    } else if (result == ConnectivityResult.mobile) {
      isNetworkWorking.value = true;
    } else if (result == ConnectivityResult.ethernet) {
      isNetworkWorking.value = true;
    } else {
      isNetworkWorking.value = false;
      return;
    }
    await _checkInternetAccess();
  }

  Future<void> _checkInternetAccess() async {
    try {
      final response = await http.get(Uri.parse('http://clients3.google.com/generate_204'))
          .timeout(const Duration(seconds: 5)); // 5s timeout for quick feedback

      if (response.statusCode == 204) {
        isNetworkWorking.value = true;
      } else {
        _handleNoInternetAccess();
      }
    } catch (e) {
      _handleNoInternetAccess();
    }
  }

  void _handleNoInternetAccess() {
    isNetworkWorking.value = false;
  }


}