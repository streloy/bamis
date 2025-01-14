import 'package:get/get.dart';

import '../controllers/community_post_my_controller.dart';

class CommunityPostMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityPostMyController>(
      () => CommunityPostMyController(),
    );
  }
}
