import 'package:get/get.dart';

import '../controllers/community_post_add_controller.dart';

class CommunityPostAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityPostAddController>(
      () => CommunityPostAddController(),
    );
  }
}
