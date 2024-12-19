import 'package:get/get.dart';

import '../controllers/pest_disease_alert_detail_controller.dart';

class PestDiseaseAlertDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PestDiseaseAlertDetailController>(
      () => PestDiseaseAlertDetailController(),
    );
  }
}
