import 'package:get/get.dart';

import '../controllers/bulletins_controller.dart';

class BulletinsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BulletinsController>(
      () => BulletinsController(),
    );
  }
}
