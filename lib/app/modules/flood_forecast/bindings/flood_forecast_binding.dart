import 'package:get/get.dart';

import '../controllers/flood_forecast_controller.dart';

class FloodForecastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FloodForecastController>(
      () => FloodForecastController(),
    );
  }
}
