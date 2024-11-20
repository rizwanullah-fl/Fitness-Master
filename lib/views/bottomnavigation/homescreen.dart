import 'package:fitness/controllers/homecontroller.dart';
import 'package:fitness/controllers/videoListcontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final VideoListController controller = Get.put(VideoListController());
  final VideoListController2 controller2 = Get.put(VideoListController2());
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
   Expanded(
  child: Obx(() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.videoController.value != null && 
        controller.videoController.value!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: controller.videoController.value!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller.videoController.value!),
                Positioned(
            top: 40,
            left: 170,
            child: Text(
  '${controller2.timerDuration.value.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
  '${(controller2.timerDuration.value.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
  style: const TextStyle(color: AppColors.accent,fontSize: 25),
),

),
          ],
        ),
      );
    } else {
      return Center(child: Text('No video available for today'));
    }
  }),
),




          const SizedBox(height: 20),
          // Start/Stop Timer Button
          SizedBox(
            width: MediaQuery.of(context).size.width - 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                controller2.isRunning.value ? controller2.stopTimer() : controller2.startTimer();
              },
              child: Obx(() => Text(
                controller2.isRunning.value ? "Stop" : "Start",
                style: const TextStyle(color: Colors.white),
              )),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
