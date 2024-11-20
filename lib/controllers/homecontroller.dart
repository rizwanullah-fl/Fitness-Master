import 'package:get/get.dart';
import 'dart:async';

class VideoListController2 extends GetxController {
  var isRunning = false.obs;
  var timerDuration = Duration(minutes: 5).obs;
  Timer? _timer;

  void startTimer() {
    if (isRunning.value) return;
    isRunning.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerDuration.value.inSeconds > 0) {
        timerDuration.value -= Duration(seconds: 1);
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isRunning.value = false;
  }

  String getFormattedTime() {
    final minutes = timerDuration.value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = timerDuration.value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}






// class VideoListController extends GetxController {
//   final videoPaths = [
//     'assets/video/onboard.mp4',
//     'assets/video/onboard.mp4',
//     'assets/video/onboard.mp4',
//   ];

//   List<VideoPlayerController> videoControllers = [];
//   var currentIndex = 0.obs;
//   var timerDuration = Duration(minutes: 5).obs;
//   Timer? _timer;
//   var isRunning = false.obs;

//   final pageController = PageController();

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeVideoPlayers();
//   }

//  void _initializeVideoPlayers() {
//   for (String path in videoPaths) {
//     var controller = VideoPlayerController.asset(path)
//       ..initialize().then((_) {
//         update();
//       })
//       ..setLooping(false); // Disable individual looping
//     videoControllers.add(controller);
//   }

//   // Start playing the first video
//   videoControllers[currentIndex.value].play();

//   // Set up a listener to detect when the video ends
//   for (var i = 0; i < videoControllers.length; i++) {
//     videoControllers[i].addListener(() {
//       if (videoControllers[i].value.position == videoControllers[i].value.duration) {
//         _onVideoEnd(i);
//       }
//     });
//   }
// }

// // Function to handle video end and play the next video in the loop
// void _onVideoEnd(int index) {
//   // Pause the current video
//   videoControllers[index].pause();

//   // Move to the next video, or loop back to the first one
//   int nextIndex = (index + 1) % videoControllers.length;
//   currentIndex.value = nextIndex;

//   // Play the next video
//   videoControllers[nextIndex].play();
// }

//   void startTimer() {
//     if (isRunning.value) return; // Prevent multiple timers

//     isRunning.value = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timerDuration.value.inSeconds > 0) {
//         timerDuration.value -= Duration(seconds: 1);
//       } else {
//         stopTimer();
//       }
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//     isRunning.value = false;
//   }

//   void resetTimer() {
//     timerDuration.value = Duration(minutes: 5);
//   }

//   void onPageChanged(int index) {
//     videoControllers[currentIndex.value].pause();
//     currentIndex.value = index;
//     videoControllers[currentIndex.value].play();
//   }

//   String getFormattedTime(Duration duration) {
//     final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }

//   @override
//   void onClose() {
//     for (var controller in videoControllers) {
//       controller.dispose();
//     }
//     pageController.dispose();
//     _timer?.cancel();
//     super.onClose();
//   }
// }
