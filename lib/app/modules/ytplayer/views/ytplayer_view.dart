import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/ytplayer_controller.dart';

class YtplayerView extends GetView<YtplayerController> {
  const YtplayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      switch (orientation) {
        case Orientation.portrait:
          return Scaffold(
            appBar: AppBar(
              title: const Text('Video Player'),
              titleSpacing: 0,
            ),
            body: YoutubePlayer(
              controller: controller.ytController,
              showVideoProgressIndicator: true,
            ),
          );
          break;
        case Orientation.landscape:
          return Scaffold(
              resizeToAvoidBottomInset: true,
              body: YoutubePlayer(
                controller: controller.ytController,
                showVideoProgressIndicator: true,
              ),
          );
          break;
      }
    });
  }
}
