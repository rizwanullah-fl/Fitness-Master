import 'package:fitness/services/uploadvideo/uploadvideo.dart';
import 'package:flutter/material.dart';

class Uploadvideo extends StatelessWidget {
  const Uploadvideo({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Upload Exercise"),
    ),
    body: ExerciseUploader(),
  );
}
}