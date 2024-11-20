import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String controller;

  VideoPlayerWidget({required this.controller});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _isMuted = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.controller))
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Auto-play the video on load
      });
      _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.6,
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextButton(
              child: Text(
                'LOG IN',
                style: TextStyles.smallRegular.copyWith(color: AppColors.white),
              ),
              onPressed: () {
                 _controller.pause();
                Get.toNamed('/Login-account');
              },
            ),
          ),
        ),
        // Positioned(
        //   left: 10,
        //   top: 10,
        //   child: Container(
        //     height: 45,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.white),
        //       borderRadius: BorderRadius.circular(18),
        //     ),
        //     child: TextButton(
        //       child: Text(
        //         'Upload',
        //         style: TextStyles.smallRegular.copyWith(color: AppColors.white),
        //       ),
        //       onPressed: () {
        //          _controller.pause();
        //         Get.toNamed('/Upload-Screen');
        //       },
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            icon: Icon(
              _isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isMuted = !_isMuted;
                _controller.setVolume(_isMuted ? 0 : 1);
              });
            },
          ),
        ),
      ],
    );
  }
}