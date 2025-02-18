import 'package:get/get.dart';

import '../controllers/bamis_portal_controller.dart';

class BamisPortalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BamisPortalController>(
      () => BamisPortalController(),
    );
  }
}
