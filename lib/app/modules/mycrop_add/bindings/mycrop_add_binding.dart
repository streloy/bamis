import 'package:get/get.dart';

import '../controllers/mycrop_add_controller.dart';

class MycropAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MycropAddController>(
      () => MycropAddController(),
    );
  }
}
