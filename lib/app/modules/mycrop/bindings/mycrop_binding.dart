import 'package:get/get.dart';

import '../controllers/mycrop_controller.dart';

class MycropBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MycropController>(
      () => MycropController(),
    );
  }
}
