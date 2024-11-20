import 'dart:io';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ExerciseUploader extends StatefulWidget {
  @override
  _ExerciseUploaderState createState() => _ExerciseUploaderState();
}

class _ExerciseUploaderState extends State<ExerciseUploader> {
  final TextEditingController _nameController = TextEditingController();
  XFile? _videoFile;
  bool _isUploading = false;

  // Pick video from gallery or camera
  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedVideo = await picker.pickVideo(source: ImageSource.gallery); // or ImageSource.camera
    setState(() {
      _videoFile = pickedVideo;
    });
  }

  // Upload video and save details to Firestore
  Future<void> _uploadExercise() async {
    if (_nameController.text.isEmpty || _videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a name and pick a video")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Define file name as the text from the text field
      final String fileName = _nameController.text.trim();
      final Reference storageRef = FirebaseStorage.instance.ref().child('exercises/$fileName.mp4');

      // Upload video to Firebase Storage
      await storageRef.putFile(File(_videoFile!.path));
      final String downloadURL = await storageRef.getDownloadURL();

      // Save metadata in Firestore
      await FirebaseFirestore.instance.collection("exercise").add({
        "name": fileName,
        "video_url": downloadURL,
        "timestamp": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exercise uploaded successfully")),
      );

      // Clear input fields
      _nameController.clear();
      setState(() {
        _videoFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading exercise: $e")),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: _nameController,
            decoration:const InputDecoration(labelText: "Enter exercise name"),
          ),
          const SizedBox(height: 16),
         Column(
          children: [
             SizedBox(
             width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50,
            child: ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.upload, color: AppColors.black),
              label:const Text(
                "Pick Video",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonSecondary,
              ),),
          ),
         const SizedBox(height: 16),
              SizedBox(
          width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50, // Set desired height for the buttons
          child: _isUploading ? Center(child: const CircularProgressIndicator(color:AppColors.accentLight ,)) : ElevatedButton.icon(
           onPressed: _isUploading ? null : _uploadExercise,
            icon: const Icon(Icons.upload, color: AppColors.black),
            label:const Text(
              "Save Video",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLight,
            ),
          ),
        ),
          ],
         )
        ],
      ),
    );
  }
}
