import 'package:fitness/controllers/videocontroller.dart';
import 'package:fitness/views/onboarding/view/button_section_widget.dart';
import 'package:fitness/views/onboarding/view/text_section_widget.dart';
import 'package:fitness/views/onboarding/view/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Obx(() {
        if (videoController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (videoController.videoURL.isNotEmpty) {
          return VideoPlayerWidget(controller: videoController.videoURL.value);
        } else {
          return Center(child: Text("No video available"));
        }
      }),
          TextSectionWidget(),
          ButtonSectionWidget(),
        ],
      ),
    );
  }
}