import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeScreen extends StatelessWidget {
  final SignUpController signUpController = Get.find<SignUpController>();
  final bool isEditMode; // true if coming from settings
  final UserController userController = Get.put(UserController());

  TimeScreen({this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'What time of the day do you prefer to workout?',
              style: TextStyles.largeRegular.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                use24hFormat: false,
                onDateTimeChanged: (DateTime newTime) {
                  signUpController.workoutTime.value = newTime;
                },
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if (isEditMode) {
                    userController.updateUserData(
                    field: 'workoutTime',
                    value: signUpController.workoutTime.value,
                  );
                  Get.back();
                  } else {
                    // Navigate to next screen or finish sign-up flow
                    signUpController.saveProfileData();
                    Get.offAllNamed('/Bottom-Screen'); // Move to the main app screen
                  }
                },
                child: Text(
                  isEditMode ? 'DONE' : 'DONE',
                  style: TextStyles.largeBold.copyWith(color: AppColors.accentLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
