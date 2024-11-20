import 'package:fitness/controllers/signupcontroller.dart';
import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:fitness/views/userdata/heightscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightScreen extends StatelessWidget {
  final SignUpController signUpController = Get.find<SignUpController>();
  final bool isEditMode; // true if accessed from settings
  final UserController userController = Get.put(UserController());

  WeightScreen({this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'What is your weight?',
            style: TextStyles.largeRegular.copyWith(color: AppColors.black),
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: signUpController.weight.value - 30),
              itemExtent: 40.0,
              onSelectedItemChanged: (index) {
                signUpController.weight.value = index + 30;
              },
              children: List<Widget>.generate(100, (index) {
                return Center(
                  child: Text(
                    '${index + 30} kg',
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
                  // Update weight in Firestore and return to settings screen
                  userController.updateUserData(
                    field: 'weight',
                    value: signUpController.weight.value,
                  );
                  Get.back();
                } else {
                                      Get.toNamed('/Height-Screen');
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
