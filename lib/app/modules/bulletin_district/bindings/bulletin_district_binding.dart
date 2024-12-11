import 'package:get/get.dart';

import '../controllers/bulletin_district_controller.dart';

class BulletinDistrictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BulletinDistrictController>(
      () => BulletinDistrictController(),
    );
  }
}
