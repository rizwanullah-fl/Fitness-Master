import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/userdata/timeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HeightScreen extends StatelessWidget {
  final SignUpController signUpController = Get.find<SignUpController>();
  final bool isEditMode; // true if coming from settings
  final UserController userController = Get.put(UserController());

  HeightScreen({this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.height,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'What is your height?',
            style: TextStyles.largeRegular.copyWith(color: AppColors.black),
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: signUpController.height.value - 100),
              itemExtent: 40.0,
              onSelectedItemChanged: (index) {
                signUpController.height.value = index + 100;
              },
              children: List<Widget>.generate(101, (index) {
                return Center(
                  child: Text(
                    '${index + 100} cm',
                    style: TextStyle(fontSize: 22),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                if (isEditMode) {
                  // Save height and return to settings
                    Get.back();
                userController.updateUserData(
                    field: 'height',
                    value: signUpController.height.value,
                  );
                
                } else {
                    Get.toNamed('/Time-Screen');
                }
              },
              child: Text(
                isEditMode ? 'DONE' : 'NEXT',
                style: TextStyles.largeBold.copyWith(color: AppColors.accentLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
