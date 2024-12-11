import 'package:get/get.dart';

import '../controllers/farm_metrics_controller.dart';

class FarmMetricsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmMetricsController>(
      () => FarmMetricsController(),
    );
  }
}
