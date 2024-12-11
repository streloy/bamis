import 'package:get/get.dart';

import '../controllers/community_post_detail_controller.dart';

class CommunityPostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityPostDetailController>(
      () => CommunityPostDetailController(),
    );
  }
}
