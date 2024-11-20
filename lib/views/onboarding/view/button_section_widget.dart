
import 'package:fitness/controllers/authcontroller.dart';
import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' show Platform;

class ButtonSectionWidget extends StatelessWidget {

  ButtonSectionWidget({required });
        final SignUpController signUpController = Get.put(SignUpController());


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isIOS ?  SizedBox(
          width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50, // Set desired height for the buttons
          child: ElevatedButton.icon(
            onPressed: () {
            },
            icon: Icon(Icons.apple, color: Colors.black),
            label: Text(
              "Continue with Apple", 
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLight,
            ),
          ),
        ) :
        SizedBox(
          width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50, // Set desired height for the buttons
          child: ElevatedButton.icon(
            onPressed: () {
              signUpController.signInWithGoogle();
            },
            icon: Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit:BoxFit.fill,              
          )  ,
            label: Text(
              "Continue with Google",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLight,
            ),
          ),
        ),
                SizedBox(height: 10),

         SizedBox(
          width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50, // Set desired height for the buttons
          child: ElevatedButton.icon(
            onPressed: () {
signUpController.signInWithFacebook();
            },
            icon: Icon(Icons.facebook, color: Colors.blue.shade400),
            label: Text(
              "Continue with Facebook",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLight,
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width - 100, // Set width to match parent width
          height: 50, // Same height as the previous button
          child: OutlinedButton(
            onPressed: () {
      //  controller.setVolume(0);
  Get.toNamed('/create-account');
// controller.setVolume(0);
            },
            child: Text(
              "Create Account",
              style: TextStyle(color: Colors.black), // Add text color for OutlinedButton
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.black), // Border color
            ),
          ),
        ),
      ],
    );
  }
}
