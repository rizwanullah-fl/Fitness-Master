import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs; // Observable to track loading state
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle login with Firebase
  Future<void> loginWithEmail() async {
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true; // Show loading indicator
      try {
        // Sign in with email and password
        await _auth.signInWithEmailAndPassword(
          email: username.value.trim(),
          password: password.value.trim(),
        );
 Get.find<UserController>().fetchUserData();
        // Fetch user data from Firestore
        await fetchAndSaveUserData();

        // Dismiss loading indicator and show success message
        isLoading.value = false;
        Get.snackbar('Success', 'Login Successfully!',
            backgroundColor: AppColors.secondary, colorText: AppColors.white);

        // Navigate to the home screen on successful login
        Get.offAllNamed('/Bottom-Screen');
      } catch (e) {
        // Dismiss loading indicator and show error message
        isLoading.value = false;
        Get.snackbar('Login Error', e.toString(),
            backgroundColor: AppColors.accent, colorText: AppColors.white);
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter both username and password',
        backgroundColor: AppColors.accent,
        colorText: AppColors.white,
      );
    }
  }

  // Function to fetch user data from Firestore and save it in SharedPreferences
  Future<void> fetchAndSaveUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        // Convert Firestore data to a map and save to SharedPreferences
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        await saveUserDataToSharedPreferences(userData);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Function to save user data to SharedPreferences
  Future<void> saveUserDataToSharedPreferences(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', data['fullName'] ?? 'N/A');
    await prefs.setString('username', data['username'] ?? 'N/A');
    await prefs.setInt('weight', data['weight'] ?? 0);
    await prefs.setInt('height', data['height'] ?? 0);
    await prefs.setString('workoutTime', data['workoutTime'] ?? '0:00');
    await prefs.setString('profileImageUrl', data['profileImageUrl'] ?? '');
  }
}
