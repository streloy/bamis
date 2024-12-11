import 'package:get/get.dart';

import '../controllers/ytplayer_controller.dart';

class YtplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YtplayerController>(
      () => YtplayerController(),
    );
  }
}
