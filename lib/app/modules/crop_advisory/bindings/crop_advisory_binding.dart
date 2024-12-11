import 'package:get/get.dart';

import '../controllers/crop_advisory_controller.dart';

class CropAdvisoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropAdvisoryController>(
      () => CropAdvisoryController(),
    );
  }
}
