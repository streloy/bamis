import 'package:get/get.dart';

import '../controllers/crop_disease_stages_detail_controller.dart';

class CropDiseaseStagesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropDiseaseStagesDetailController>(
      () => CropDiseaseStagesDetailController(),
    );
  }
}
