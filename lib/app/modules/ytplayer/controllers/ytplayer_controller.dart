import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtplayerController extends GetxController {
  //TODO: Implement YtplayerController

  var title = "".obs;
  var youtube = "".obs;
  late YoutubePlayerController ytController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dynamic decode = Get.arguments;
    title.value = decode['title'];
    youtube.value = decode['youtube'];

    final _videoId = YoutubePlayer.convertUrlToId(youtube.value);
    ytController = YoutubePlayerController(
      initialVideoId: _videoId!,
      flags: YoutubePlayerFlags(

        autoPlay: false
      )
    );
  }

}
