import 'package:get/get.dart';

import '../controllers/all_module_controller.dart';

class AllModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllModuleController>(
      () => AllModuleController(),
    );
  }
}
