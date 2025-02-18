import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/bamis_portal_controller.dart';

class BamisPortalView extends GetView<BamisPortalController> {
  const BamisPortalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text("bamis_portal_title".tr),
        ),
        body: Stack(
            alignment: Alignment.center,
            children: [
              WebViewWidget(controller: controller.webViewController),
              Obx(()=> Visibility(
                  visible: controller.isPageLoading.value != 100,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors().app_secondary,
                    color: AppColors().app_primary,
                  )
              ))
            ]
        )
    );
  }
}
