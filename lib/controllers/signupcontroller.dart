import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var fullName = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var weight = 75.obs;
  var height = 145.obs;
  var workoutTime = DateTime.now().obs;

  // Validation function to check if all fields are filled
  bool validateFields() {
    return fullName.value.isNotEmpty &&
        username.value.isNotEmpty &&
        password.value.isNotEmpty;
  }

  // Function to handle Firebase sign-up
  Future<void> signUpWithEmail() async {
    if (validateFields()) {
      // Show loading indicator
      Get.dialog(
        Center(child: CircularProgressIndicator(
          color: AppColors.accent,
        )),
        barrierDismissible: false,
      );
      try {
        // Attempt to create a new user with email and password
        await _auth.createUserWithEmailAndPassword(
          email: username.value.trim(),
          password: password.value.trim(),
        );
        // Navigate to weight screen
        Get.offAllNamed('/weight-Screen');
      } catch (e) {
        Get.snackbar('Sign Up Error', e.toString(),
            backgroundColor: AppColors.warning, colorText: AppColors.white);
      } finally {
        // Hide loading indicator
        Get.back();
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: AppColors.warning,
        colorText: AppColors.white,
      );
    }
  }

  Future<void> saveProfileData() async {
    // Show loading indicator
    Get.dialog(
      Center(child:  CircularProgressIndicator(
          color: AppColors.accent,
        )),
      barrierDismissible: false,
    );
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).set({
        'fullName': fullName.value,
        'username': username.value,
        'weight': weight.value,
        'height': height.value,
        'workoutTime': workoutTime.value.toIso8601String(),
      });
      Get.snackbar('Success', 'Profile saved successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
      Get.offAllNamed('/Bottom-Screen');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile data: $e',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
      print("Firestore Save Error: $e");
    } finally {
      // Hide loading indicator
      Get.back();
    }
  }

  Future<void> updateProfileData({String? field, dynamic value}) async {
    // Show loading indicator
    Get.dialog(
      Center(child:  CircularProgressIndicator(
          color: AppColors.accent,
        )),
      barrierDismissible: false,
    );
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).update({
        field!: value,
      });
      Get.snackbar('Success', '$field updated successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile data: $e',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
      print("Firestore Update Error: $e");
    } finally {
      // Hide loading indicator
      Get.back();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Show loading indicator
    Get.dialog(
      Center(child:  CircularProgressIndicator(
          color: AppColors.accent,
        )),
      barrierDismissible: false,
    );
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar('Login Error', 'Google login canceled by user.',
            backgroundColor: AppColors.accent, colorText: AppColors.white);
        throw Exception('Google sign-in canceled by user');
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).set({
            'fullName': user.displayName ?? 'Anonymous User',
            'username': user.email ?? 'unknown@example.com',
          }, SetOptions(merge: true));
           Get.snackbar('Success', 'Login successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
        } else {
          await _firestore.collection('users').doc(user.uid).set({
            'fullName': user.displayName ?? 'Anonymous User',
            'username': user.email ?? 'unknown@example.com',
            'height': 0,
            'weight': 0,
            'workoutTime': DateTime.now().toIso8601String(),
          });
           Get.snackbar('Success', 'Login successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
        }
        Get.offAllNamed('/Bottom-Screen');
      }
      return userCredential;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
      print("Google Sign-In Error: $e");
      throw e;
    } finally {
      // Hide loading indicator
      Get.back();
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Show loading indicator
    Get.dialog(
      Center(child:  CircularProgressIndicator(
          color: AppColors.accent,
        )),
      barrierDismissible: false,
    );
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        final user = userCredential.user;
        if (user != null) {
          final userDoc = await _firestore.collection('users').doc(user.uid).get();
          if (userDoc.exists) {
            await _firestore.collection('users').doc(user.uid).set({
              'fullName': user.displayName ?? 'Anonymous User',
              'username': user.email ?? 'unknown@example.com',
            }, SetOptions(merge: true));
             Get.snackbar('Success', 'Login successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
          } else {
            await _firestore.collection('users').doc(user.uid).set({
              'fullName': user.displayName ?? 'Anonymous User',
              'username': user.email ?? 'unknown@example.com',
              'height': 0,
              'weight': 0,
              'workoutTime': DateTime.now().toIso8601String(),
            });
             Get.snackbar('Success', 'Login successfully!',
          backgroundColor: AppColors.secondary, colorText: AppColors.white);
          }
          Get.offAllNamed('/Bottom-Screen');
        }
        return userCredential;
      } else {
        Get.snackbar(
          'Login Error',
          'Facebook login failed: ${loginResult.message}',
          backgroundColor: AppColors.accent,
          colorText: AppColors.white,
        );
        throw Exception('Facebook login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: AppColors.warning, colorText: AppColors.white);
      print("Facebook Sign-In Error: $e");
      throw e;
    } finally {
      // Hide loading indicator
      Get.back();
    }
  }
}
