import 'package:get/get.dart';

import '../controllers/crop_adviosry_stage_detail_controller.dart';

class CropAdviosryStageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropAdviosryStageDetailController>(
      () => CropAdviosryStageDetailController(),
    );
  }
}
