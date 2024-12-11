import 'package:get/get.dart';

import '../controllers/elibrary_controller.dart';

class ElibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElibraryController>(
      () => ElibraryController(),
    );
  }
}
