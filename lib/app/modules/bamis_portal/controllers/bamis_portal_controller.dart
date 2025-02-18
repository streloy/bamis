import 'dart:convert';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/ApiURL.dart';

class BamisPortalController extends GetxController {
  //TODO: Implement BamisPortalController

  var title = "".obs;
  var isPageLoading = 0.obs;
  final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(ApiURL.webview_url)).obs;

  late var url = "";

  @override
  void onInit() async{
    super.onInit();

    var response = await http.get(Uri.parse(ApiURL.bamis_portal_url));
    dynamic decode = await jsonDecode(response.body);
    url = await decode['result'];

    webViewController
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) { isPageLoading.value = 0; print('Progress : ${isPageLoading.value}'); },
          onProgress: (int progress) { isPageLoading.value = progress; print('Progress : ${isPageLoading.value}'); },
          onPageFinished: (url) { isPageLoading.value = 100; print('Progress : ${isPageLoading.value}'); }
      ))
      ..loadRequest(Uri.parse(url));
  }
}
