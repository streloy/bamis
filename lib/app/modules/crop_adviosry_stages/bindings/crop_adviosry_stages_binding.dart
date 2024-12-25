import 'package:get/get.dart';

import '../controllers/crop_adviosry_stages_controller.dart';

class CropAdviosryStagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropAdviosryStagesController>(
      () => CropAdviosryStagesController(),
    );
  }
}
