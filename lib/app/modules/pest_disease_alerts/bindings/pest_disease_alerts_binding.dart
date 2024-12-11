import 'package:get/get.dart';

import '../controllers/pest_disease_alerts_controller.dart';

class PestDiseaseAlertsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PestDiseaseAlertsController>(
      () => PestDiseaseAlertsController(),
    );
  }
}
