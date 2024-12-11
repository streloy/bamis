import 'package:get/get.dart';

import '../controllers/bulletin_special_controller.dart';

class BulletinSpecialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BulletinSpecialController>(
      () => BulletinSpecialController(),
    );
  }
}
