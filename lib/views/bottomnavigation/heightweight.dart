

import 'package:fitness/controllers/usercontroller.dart';
import 'package:fitness/services/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Userheightweight extends StatelessWidget {
    final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
     double bmi = calculateBMI(userController.user.value.weight, userController.user.value.height);
    String bmiCategory = getBMICategory(bmi);
    String imagePath = getBMIImage(bmi);
    return Scaffold( 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Height indicator
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 450,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Height Indicator on the left
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${userController.user.value.height} cm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        // Left scale indicator
                        Container(
                          width: 30,
                          height: 380,
                          child: CustomPaint(
                            painter: ScalePainter(),
                          ),
                        ),
                      ],
                    ),
                    // Dynamic Image based on BMI
                    Container(
                      height: 400,
                      width: 200,
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                    // Weight Indicator on the right
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${userController.user.value.weight} kg',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        // Right scale indicator
                        Container(
                          width: 30,
                          height: 380,
                          child: CustomPaint(
                            painter: ScalePainter(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          // BMI Status
          Column(
            children: [
              Text(
                'YOU ARE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                bmiCategory.toUpperCase(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),);
  }
    double calculateBMI(int weight, int height) {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String getBMIImage(double bmi) {
    if (bmi < 18.5) {
      return 'assets/images/bodies/underweight.png';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'assets/images/bodies/normal.png';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'assets/images/bodies/overweight.png';
    } else {
      return 'assets/images/bodies/obese.png';
    }
  }
}

  

  String getBMIImage(double bmi) {
    if (bmi < 18.5) {
      return 'assets/underweight.png';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'assets/normal.png';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'assets/overweight.png';
    } else {
      return 'assets/obese.png';
    }
  }

class ScalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    for (double y = 0; y <= size.height; y += 10) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}