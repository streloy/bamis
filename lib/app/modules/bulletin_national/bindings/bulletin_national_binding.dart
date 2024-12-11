import 'package:get/get.dart';

import '../controllers/bulletin_national_controller.dart';

class BulletinNationalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BulletinNationalController>(
      () => BulletinNationalController(),
    );
  }
}
