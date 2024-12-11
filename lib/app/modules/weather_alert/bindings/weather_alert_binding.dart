import 'package:get/get.dart';

import '../controllers/weather_alert_controller.dart';

class WeatherAlertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherAlertController>(
      () => WeatherAlertController(),
    );
  }
}
