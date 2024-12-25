import 'package:get/get.dart';

import '../controllers/crop_disease_stages_controller.dart';

class CropDiseaseStagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropDiseaseStagesController>(
      () => CropDiseaseStagesController(),
    );
  }
}
