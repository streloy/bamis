import 'package:get/get.dart';

import '../controllers/crop_disease_controller.dart';

class CropDiseaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CropDiseaseController>(
      () => CropDiseaseController(),
    );
  }
}
