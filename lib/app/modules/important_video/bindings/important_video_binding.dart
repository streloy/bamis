import 'package:get/get.dart';

import '../controllers/important_video_controller.dart';

class ImportantVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportantVideoController>(
      () => ImportantVideoController(),
    );
  }
}
