import 'package:fitness/services/videosingleton.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';



class VideoListController extends GetxController {
  final VideoService _videoService = VideoService();
  Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDailyVideo();
  }

  Future<void> loadDailyVideo() async {
    isLoading.value = true;
    videoController.value = await _videoService.getDailyVideoController();
    videoController.value!.play();
    isLoading.value = false;
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    super.onClose();
  }
}
