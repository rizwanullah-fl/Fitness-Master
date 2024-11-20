import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/models/usermodel.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserController extends GetxController {
  var user = UserModel(
    fullName: 'N/A',
    username: 'N/A',
    weight: 0,
    height: 0,
    workoutTime: '0:00',
    profileImageUrl: '', // Add this field to store the profile image URL
  ).obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File file = File(image.path);

        // Upload the image to Firebase Storage and get the URL
        String downloadUrl = await uploadImageToStorage(file);

        // Update profile image in Firestore and locally
        await updateUserData(field: 'profileImageUrl', value: downloadUrl);
        user.value.profileImageUrl = downloadUrl; // Update locally
        user.refresh();
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar('Error', 'Failed to pick image',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
    }
  }
    Future<String> uploadImageToStorage(File file) async {
    try {
      String uid = _auth.currentUser!.uid;
      Reference storageRef = FirebaseStorage.instance.ref().child('users/$uid/profile.jpg');
      await storageRef.putFile(file);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      throw e;
    }
  }

  // Load user data from SharedPreferences or Firestore
Future<void> loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // If no data in SharedPreferences, fetch from Firestore
  if (!prefs.containsKey('fullName')) {
    await fetchUserData();
  } else {
    // Load from SharedPreferences if available
    user.value = UserModel(
      fullName: prefs.getString('fullName') ?? 'N/A',
      username: prefs.getString('username') ?? 'N/A',
      weight: prefs.getInt('weight') ?? 0,
      height: prefs.getInt('height') ?? 0,
      workoutTime: prefs.getString('workoutTime') ?? '0:00',
      profileImageUrl: prefs.getString('profileImageUrl') ?? '',
    );
    user.refresh();
  }
}



  // Fetch user data from Firestore
Future<void> fetchUserData() async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print("Fetching data for UID: $uid");
    
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      print("Document data: ${doc.data()}");
      
      user.value = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      saveToSharedPreferences(); // Save to SharedPreferences for offline use
      user.refresh(); // Update the UI
      
      print("User data loaded: ${user.value}");
    } else {
      print("No document found for UID: $uid");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}


  // Save user data to SharedPreferences
Future<void> saveToSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('fullName', user.value.fullName);
  prefs.setString('username', user.value.username);
  prefs.setInt('weight', user.value.weight);
  prefs.setInt('height', user.value.height);
  prefs.setString('workoutTime', user.value.workoutTime);
  prefs.setString('profileImageUrl', user.value.profileImageUrl); // Save profile image URL
}


  // Update user data locally, in SharedPreferences, and Firestore
 Future<void> updateUserData({String? field, dynamic value}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
     dynamic firestoreValue = field == 'workoutTime' && value is DateTime
          ? value.toIso8601String()
          : value;
      // Update in Firestore
      await _firestore.collection('users').doc(uid).update({field!: value});

      // Update locally in user observable model
      switch (field) {
        case 'profileImageUrl':
          user.value.profileImageUrl = value;
          break;
        case 'fullName':
          user.value.fullName = value;
          break;
        case 'username':
          user.value.username = value;
          break;
        case 'weight':
          user.value.weight = value;
          break;
        case 'height':
          user.value.height = value;
          break;
        case 'workoutTime':
       user.value.workoutTime = firestoreValue;
          break;
      }
      user.refresh();
      saveToSharedPreferences();
    } catch (e) {
      print("Error updating user data: $e");
      Get.snackbar('Error', 'Failed to update profile data',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
    }
  }

 String get formattedWorkoutTime {
    if (user.value.workoutTime == '0:00') return 'N/A';
    try {
      DateTime time = DateTime.parse(user.value.workoutTime);
      return DateFormat.jm().format(time); // Formats to '3:40 PM'
    } catch (e) {
      print("Error parsing workoutTime: $e");
      return 'N/A';
    }
  }
}